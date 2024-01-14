import re

def validate_name(name: str) -> bool:
    # Verificar que el nombre no esté vacío, no exceda los 30 caracteres y no contenga números
    return 0 < len(name) <= 30 and not any(char.isdigit() for char in name)

def validate_last_name(last_name: str) -> bool:
    # Verificar que el apellido no esté vacío, no exceda los 30 caracteres y no contenga números
    return 0 < len(last_name) <= 30 and not any(char.isdigit() for char in last_name)

def validate_phone(phone: str) -> bool:
    # Verificar que el número de teléfono no esté vacío, no exceda los 15 caracteres y solo contenga dígitos
    return 0 < len(phone) <= 15 and phone.isdigit()

def validate_email(email: str) -> bool:
    email = email.strip()
    # Expresión regular para validar direcciones de correo electrónico
    email_regex = re.compile(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
    # Verificar longitud y formato con la expresión regular
    return 0 < len(email) <= 50 and bool(email_regex.match(email))
