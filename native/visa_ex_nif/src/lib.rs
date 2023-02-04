use std::ffi::CString;
use visa_rs::{DefaultRM, AsResourceManager};

#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}

#[rustler::nif]
fn list_instr() {
    let rm = DefaultRM::new().unwrap();
    let mut list = rm.find_res_list(&CString::new("?*INSTR").unwrap().into()).unwrap();
    while let Some(n) = list.find_next().unwrap() {
        eprintln!("{}", n);
    }
}

rustler::init!("Elixir.VisaEx", [add, list_instr]);
