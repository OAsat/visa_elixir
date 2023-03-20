use rustler::{Error, NifResult};
use std::ffi::CString;
use std::io::{BufReader, BufRead, Write};
use visa_rs::{flags::AccessMode, DefaultRM, TIMEOUT_IMMEDIATE};

fn convert_visa_error(error: visa_rs::Error) -> Error {
    Error::Term(Box::new(error.0.to_string()))
}

fn convert_cstring_error(error: std::ffi::NulError) -> Error {
    Error::Term(Box::new(error.to_string()))
}

fn convert_io_error(error: std::io::Error) -> Error {
    Error::Term(Box::new(error.to_string()))
}

fn get_resource_manager() -> NifResult<DefaultRM> {
    DefaultRM::new().map_err(convert_visa_error)
}

#[rustler::nif]
fn list_resources(message: String) -> NifResult<Vec<String>> {
    let rm = get_resource_manager()?;
    let mut list = rm
        .find_res_list(&CString::new(message).map_err(convert_cstring_error)?.into())
        .map_err(convert_visa_error)?;
    let mut vias_vec = Vec::new();
    while let Some(n) = list.find_next().map_err(convert_visa_error)? {
        vias_vec.push(n.to_string());
    }
    Ok(vias_vec)
}

#[rustler::nif]
fn write(address: String, message: String) -> NifResult<()> {
    let rm = get_resource_manager()?;
    let resource = &CString::new(address).map_err(convert_cstring_error)?.into();
    let mut instr = rm
        .open(resource, AccessMode::NO_LOCK, TIMEOUT_IMMEDIATE)
        .map_err(convert_visa_error)?;
    instr.write_all(message.as_bytes()).map_err(convert_io_error)?;
    Ok(())
}

#[rustler::nif]
fn query(address: String, message: String) -> NifResult<String> {
    let rm = get_resource_manager()?;
    let resource = &CString::new(address).map_err(convert_cstring_error)?.into();
    let mut instr = rm
        .open(resource, AccessMode::NO_LOCK, TIMEOUT_IMMEDIATE)
        .map_err(convert_visa_error)?;
    instr.write_all(message.as_bytes()).map_err(convert_io_error)?;
    let mut buf_reader = BufReader::new(instr);
    let mut buf = String::new();
    buf_reader.read_line(&mut buf).map_err(convert_io_error)?;
    Ok(buf)
}

rustler::init!("Elixir.ExVisa.Native", [list_resources, query, write]);
