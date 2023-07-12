import pyvisa


def list_resources(query):
    return pyvisa.ResourceManager().list_resources(query)


def query(address, message, write_term, read_term):
    address_str = address.decode("utf-8")
    message_str = message.decode("utf-8")
    write_term_str = write_term.decode("utf-8")
    read_term_str = read_term.decode("utf-8")
    return pyvisa.ResourceManager().open_resource(
        address_str,
        write_termination=write_term_str,
        read_termination=read_term_str,
        ).query(message_str)


def write(address, message, write_term, read_term):
    address_str = address.decode("utf-8")
    message_str = message.decode("utf-8")
    write_term_str = write_term.decode("utf-8")
    read_term_str = read_term.decode("utf-8")
    return pyvisa.ResourceManager().open_resource(
        address_str,
        write_termination=write_term_str,
        read_termination=read_term_str,
        ).write(message_str)