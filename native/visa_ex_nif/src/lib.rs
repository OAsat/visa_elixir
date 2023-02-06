use rustler::{Error, NifResult};
use std::ffi::CString;
use visa_rs::DefaultRM;

fn convert_visa_error(error: visa_rs::Error) -> Error {
    Error::Term(Box::new(error.0.to_string()))
}

#[rustler::nif]
fn list_resources(query: String) -> NifResult<Vec<String>> {
    let rm = DefaultRM::new().map_err(convert_visa_error)?;
    let mut list = rm
        .find_res_list(&CString::new(query).unwrap().into())
        .map_err(convert_visa_error)?;
    let mut vias_vec = Vec::new();
    while let Some(n) = list.find_next().map_err(convert_visa_error)? {
        vias_vec.push(n.to_string());
    }
    Ok(vias_vec)
}

rustler::init!("Elixir.VisaEx.Native", [list_resources]);
