/*
countyfips: Stata program for merging U.S. county identifiers
Author: Christopher B. Goodman
Contact: cgoodman@niu.edu
Date: NA
Version: 0.9.1
*/

capture program drop countyfips
program define countyfips

  version 12.1
  syntax, [Name(string) Statefips(string) Countyfips(string) Fips(string) Statecode(string) Countycode(string) NOGENerate]

    cap quietly findfile countyfips.dta, path("`c(sysdir_personal)'countyfips_data/")

    if _rc==601 {
      preserve
      clear
      quietly findfile countyfips_data.ado
      cap insheet using "`r(fn)'", tab
      label var fips "5-digit FIPS Code"
      label var county_name "County Name"
      label var state_abb "State Abbreviation"
      label var state_fips "State FIPS Code"
      label var county_fips "County FIPS Code"
      label var state_code "State Census Code"
      label var county_code "County Census Code"
      cap mkdir "`c(sysdir_personal)'"
      cap mkdir "`c(sysdir_personal)'countyfips_data"
      cap save "`c(sysdir_personal)'countyfips_data/countyfips.dta"
      restore
    }

  if "`nogenerate'" != "" {

    if "`name'" != "" & "`statefips'" != "" {
      local nm "`name'"
      local st "`statefips'"
      rename `nm' county_name
      rename `st' state_fips
      replace county_name=upper(county_name)
      merge m:1 county_name state_fips using "`c(sysdir_personal)'countyfips_data/countyfips.dta", nogen keep(match master)
      rename county_name `nm'
      rename state_fips `st'
    }

    else if "`name'" != "" & "`statecode'" != "" {
      local nm "`name'"
      local statecode "`statecode'"
      rename `nm' county_name
      rename `statecode' state_code
      replace county_name=upper(county_name)
      merge m:1 county_name state_code using "`c(sysdir_personal)'countyfips_data/countyfips.dta", nogen keep(match master)
      rename county_name `nm'
      rename state_code `statecode'
    }

    else if "`fips'" != "" {
      local fips "`fips'"
      rename `fips' fips
      merge m:1 fips using "`c(sysdir_personal)'countyfips_data/countyfips.dta", nogen keep(match master)
      rename fips `fips'
    }

    else if "`statefips'" != "" & "`countyfips'" != "" {
      local statefips "`statefips'"
      local countyfips "`countyfips'"
      rename `statefips' state_fips
      rename `countyfips' county_fips
      merge m:1 state_fips county_fips using "`c(sysdir_personal)'countyfips_data/countyfips.dta", nogen keep(match master)
      rename state_fips `statefips'
      rename county_fips `countyfips'
    }

    else if "`statecode'" != "" & "`countycode'" != "" {
      preserve
      clear
      cap quietly use "`c(sysdir_personal)'countyfips_data/countyfips.dta"
      quietly drop if county_code==.
      tempfile countyfips_datatemp
      cap save `countyfips_datatemp'
      restore
      local statecode "`statecode'"
      local countycode "`countycode'"
      rename `statecode' state_code
      rename `countycode' county_code
      merge m:1 state_code county_code using `countyfips_datatemp', nogen keep(match master)
      rename state_code `statecode'
      rename county_code `countycode'
    }

  }

  else if "`name'" != "" & "`statefips'" != "" {
    local nm "`name'"
    local st "`statefips'"
    rename `nm' county_name
    rename `st' state_fips
    replace county_name=upper(county_name)
    merge m:1 county_name state_fips using "`c(sysdir_personal)'countyfips_data/countyfips.dta"
    rename county_name `nm'
    rename state_fips `st'
  }

  else if "`name'" != "" & "`statecode'" != "" {
    local nm "`name'"
    local statecode "`statecode'"
    rename `nm' county_name
    rename `statecode' state_code
    replace county_name=upper(county_name)
    merge m:1 county_name state_code using "`c(sysdir_personal)'countyfips_data/countyfips.dta"
    rename county_name `nm'
    rename state_code `statecode'
  }

  else if "`fips'" != "" {
    local fips "`fips'"
    rename `fips' fips
    merge m:1 fips using "`c(sysdir_personal)'countyfips_data/countyfips.dta"
    rename fips `fips'
  }

  else if "`statefips'" != "" & "`countyfips'" != "" {
    local statefips "`statefips'"
    local countyfips "`countyfips'"
    rename `statefips' state_fips
    rename `countyfips' county_fips
    merge m:1 state_fips county_fips using "`c(sysdir_personal)'countyfips_data/countyfips.dta"
    rename state_fips `statefips'
    rename county_fips `countyfips'
  }

  else if "`statecode'" != "" & "`countycode'" != "" {
    preserve
    clear
    cap quietly use "`c(sysdir_personal)'countyfips_data/countyfips.dta"
    quietly drop if county_code==.
    tempfile countyfips_datatemp
    cap save `countyfips_datatemp'
    restore
    local statecode "`statecode'"
    local countycode "`countycode'"
    rename `statecode' state_code
    rename `countycode' county_code
    merge m:1 state_code county_code using `countyfips_datatemp'
    rename state_code `statecode'
    rename county_code `countycode'
  }

end
