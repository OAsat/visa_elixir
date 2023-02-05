use std::ffi::CString;
use visa_rs::{DefaultRM, AsResourceManager, Result as VResult, Error as VError};
use rustler::{Error as RError};

mod atoms {
    rustler::atoms! {
        ok,
        error,
        unknown
    }
}

#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}

fn to_rustler_error(visa_rs_error: VError) -> RError {
    RError::Term(Box::new(visa_rs_error.0.to_string()))
}

fn _list_instr() -> VResult<Vec<String>> {
    let rm = DefaultRM::new()?;
    let mut list = rm.find_res_list(&CString::new("?*INSTR").unwrap().into())?;
    let mut vias_vec = Vec::new();
    while let Some(n) = list.find_next()? {
        vias_vec.push(n.to_string());
    };
    Ok(vias_vec)
}

#[rustler::nif]
fn list_instr() -> Result<Vec<String>, RError> {
    let list = match _list_instr() {
        Ok(success) => {
            success
        },
        Err(err) => return Err(to_rustler_error(err))
    };
    Ok(list)
}

rustler::init!("Elixir.VisaEx", [add, list_instr]);
