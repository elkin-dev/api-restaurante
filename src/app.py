from flask import Flask, jsonify, request
from config import config
import psycopg2
from psycopg2 import Error


from validaciones import *

app = Flask(__name__)


def create_db_connection():
    connection = psycopg2.connect(
        host=app.config["DB_SERVER"],
        port=app.config["DB_PORT"],
        database=app.config["DB_NAME"],
        user=app.config["DB_USERNAME"],
        password=app.config["DB_PASSWORD"],
    )
    return connection


from psycopg2 import Error


@app.route("/restaurante", methods=["GET"])
def list_customer_data():
    try:
        with create_db_connection() as connection:
            with connection.cursor() as cursor:
                sql = """
                    SELECT
                        c.pk_id_cliente AS id_cliente,
                        cast(c.des_nombre || ' ' || c.des_apellido AS CHARACTER VARYING) AS nombre,
                        c.des_telefono as telefono,
                        cast(r.pk_id_reserva AS INTEGER) AS codigo_reserva,
                        cast(m.num_numero_mesa AS INTEGER) AS numero_mesa,
                        CAST(m.num_capacidad AS INTEGER) AS capacidad_mesa,
                        re.des_nombre AS nombre_restaurante,
                        to_char(c.fec_actualizacion, 'YYYY-MM-DD HH24:MI:SS') AS fecha_actualizacion
                    FROM cliente c
                    INNER JOIN reserva r ON c.pk_id_cliente = r.fk_id_cliente
                    INNER JOIN mesa m ON m.pk_id_mesa = r.fk_id_mesa
                    INNER JOIN restaurante re ON re.pk_id_restaurante = m.fk_id_restaurante
                """
                cursor.execute(sql)
                results = cursor.fetchall()

                arr_data = []
                for row in results:
                    data = {
                        "id_cliente": row[0],
                        "nombre": row[1],
                        "telefono": row[2],
                        "codigo_reserva": row[3],
                        "numero_mesa": row[4],
                        "capacidad_mesa": row[5],
                        "nombre_restaurante": row[6],
                        "actualizacion_dato": row[7],
                    }
                    arr_data.append(data)

                return jsonify(
                    {"datos_cliente": arr_data, "message": "Clientes listados"}
                )
    except Error as ex:
        return jsonify({"message": f"Error: {ex}"})


def read_customer_data_bd(code):
    try:
        with create_db_connection() as connection:
            with connection.cursor() as cursor:
                sql = """ 
                    SELECT pk_id_cliente,
                        des_nombre,
                        des_apellido,
                        des_telefono,
                        des_email,
                        fec_creacion,
                        fec_actualizacion
                    FROM public.cliente
                    WHERE pk_id_cliente = %s;
                """
                cursor.execute(sql, (code,))
                results = cursor.fetchone()
                if results is not None:
                    data = {
                        "id": results[0],
                        "nombre": results[1],
                        "apellido": results[2],
                        "telefono": results[3],
                        "email": results[4],
                        "fec_creacion": results[5],
                        "fec_actualizacion": results[6],
                    }
                    return data
                else:
                    return None
    except Error as ex:
        print(f"Error en la consulta SQL: {ex}")
        return None


@app.route("/restaurante/<code>", methods=["GET"])
def read_customer_data(code):
    try:
        customer = read_customer_data_bd(code)
        if customer is not None:
            return jsonify(
                {
                    "customer": customer,
                    "message": "Cliente encontrado!",
                    "success": True,
                }
            )
        else:
            return jsonify({"message": "Cliente no encontrado!", "success": False})
    except Error as ex:
        return jsonify({"message": f"Error: {ex}", "success": False})


@app.route("/restaurante", methods=["POST"])
def register_customer():
    if (
        validate_name(request.json["nombre"])
        and validate_last_name(request.json["apellido"])
        and validate_phone(request.json["telefono"])
        and validate_email(request.json["email"])
    ):
        try:
            with create_db_connection() as connection:
                with connection.cursor() as cursor:
                    sql = """
                        INSERT INTO cliente(des_nombre, des_apellido, des_telefono, des_email)
                        VALUES (%s, %s, %s, %s)
                    """
                    cursor.execute(
                        sql,
                        (
                            request.json["nombre"],
                            request.json["apellido"],
                            request.json["telefono"],
                            request.json["email"],
                        ),
                    )
                    connection.commit()
                    return jsonify({"message": "Cliente registrado", "success": True})

        except Exception as ex:
            return jsonify({"message": f"Error: {ex}", "success": False})
    else:
        return jsonify({"message": "Parámetros inválidos...", "success": False})


@app.route("/restaurante/<code>", methods=["PUT"])
def update_customer(code):
    if (
        validate_name(request.json["nombre"])
        and validate_last_name(request.json["apellido"])
        and validate_phone(request.json["telefono"])
        and validate_email(request.json["email"])
    ):
        try:
            customer = read_customer_data(code)
            if customer is not None:
                with create_db_connection() as connection:
                    with connection.cursor() as cursor:
                        sql = """
                            UPDATE cliente
                            SET des_nombre = %s,
                                des_apellido = %s,
                                des_telefono = %s,
                                des_email = %s
                            WHERE pk_id_cliente = %s
                        """
                        cursor.execute(
                            sql,
                            (
                                request.json["nombre"],
                                request.json["apellido"],
                                request.json["telefono"],
                                request.json["email"],
                                code,
                            ),
                        )
                        connection.commit()
                        return jsonify(
                            {"message": "Cliente actualizado", "success": True}
                        )
            else:
                return jsonify({"message": "Cliente no encontrado", "success": False})
        except Exception as ex:
            return jsonify({"message": f"Error: {ex}", "success": False})
    else:
        return jsonify({"message": "Parámetros inválidos...", "success": False})


@app.route("/restaurante/<code>", methods=["DELETE"])
def delete_customer(code):
    try:
        customer = read_customer_data(code)
        if customer is not None:
            with create_db_connection() as connection:
                with connection.cursor() as cursor:
                    sql = """DELETE FROM cliente WHERE pk_id_cliente = %s;"""
                    cursor.execute(sql, (code,))
                    connection.commit()
                    return jsonify({"message": "Cliente eliminado", "success": True})
        else:
            return jsonify({"message": "Cliente no eliminado", "success": False})
    except Exception as ex:
        return jsonify({"message": f"Error {ex}", "success": False})


def page_no_found(error):
    return f"""
        <div class="error-message">
            ¡<span style="font-weight: bold;">Error 404</span>! - La página que intentas buscar no existe. Por favor, verifica la URL.
        </div>
    """


if __name__ == "__main__":
    app.config.from_object(config["development"])
    app.register_error_handler(404, page_no_found)
    app.run(debug=True)
