import pyvisa


def list_resources(query):
    return pyvisa.ResourceManager().list_resources(query)


def query(address, message):
    address_str = address.decode("utf-8")
    message_str = message.decode("utf-8")
    return pyvisa.ResourceManager().open_resource(address_str).query(message_str)


def write(address, message):
    address_str = address.decode("utf-8")
    message_str = message.decode("utf-8")
    return pyvisa.ResourceManager().open_resource(address_str).write(message_str)