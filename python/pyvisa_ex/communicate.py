import pyvisa


def list_resources(query):
    return pyvisa.ResourceManager().list_resources(query)


def query(address, message):
    return pyvisa.ResourceManager().open_resource(address).query(message)


def write(address, message):
    return pyvisa.ResourceManager().open_resource(address).write(message)