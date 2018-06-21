{smcl}
{* *! Version 0.9.0 06212018}
{title:Title}

{p 4 8}{cmd:countyfips} {hline 2} Stata program for merging U.S. county identifiers

{title:Syntax}

{p 8 16 2}
{opt countyfips} [{cmd:,} {it:options}] {opt nogen:erate}

{title:Description}

{pstd}
{cmd:countyfips} is a simple Stata crosswalk program for adding various county-level
identifiers (name, FIPS, Census codes) that may be missing from your dataset.
The purpose of this program is to facilitate merging datasets that do not share
a common identifier.

{pstd}
{cmd:countyfips} is compatible with Stata version 12.1+. It may be compatible
with previous versions, but it has not been tested in those environments.

{title:Options}

One of the following {cmd:arguments} is required.

{phang}
{opt n:ame(string)} Use this option to merge using county name string. (string)
specifies the variable name in the master dataset. {cmd:statefips} or {cmd:statecode} is required
for this option.

{phang}
{opt s:tatefips(string)} Use this option to merge using the two-digit state FIPS code.
(string) specifies the variable name in the master dataset. {cmd:countyfips} is required
for this option.

{phang}
{opt c:ountyfips(string)} Use this option to merge using the three-digit county FIPS code.
(string) specifies the variable name in the master dataset. {cmd:statefips} is required
for this option.

{phang}
{opt f:ips(string)} Use this option to merge using the five-digit county-level FIPS code.
(string) specifies the variable name in the master dataset.

{phang}
{opt s:tatecode(string)} Use this option to merge using the two-digit state-level Census code.
(string) specifies the variable name in the master dataset. {cmd:countycode} is required
for this option.

{phang}
{opt c:ountycode(string)} Use this option to merge using the three-digit county-level Census code.
(string) specifies the variable name in the master dataset. {cmd:statecode} is required
for this option.

Optional

{phang}
{opt nogen:erate} Use this option if you do not want to mark merge results with
the new variable, {cmd:_merge}. This option will also limit your dataset to matched
observations and unmatched master observations.

{title:Examples}

{pstd}{cmd:countyfips} offers three methods of merging using either county names,
five-digit county FIPS codes, or the combination of two-digit state FIPS and three-digit
county FIPS codes.{p_end}

{pstd}Merging with {cmd:name} where {it:county} is the name of county{p_end}
{phang2}{cmd:. countyfips, name(}{it:county}{cmd:) statefips(}{it:stfips}{cmd:)}{p_end}
{pstd}or{p_end}
{phang2}{cmd:. countyfips, name(}{it:county}{cmd:) statecode(}{it:stcode}{cmd:)}{p_end}

{pstd}Merging with {cmd:fips}{p_end}
{phang2}{cmd:. countyfips, fips(}{it:county}{cmd:)}{p_end}

{pstd}Merging with {cmd:statefips} and {cmd:countyfips}{p_end}
{phang2}{cmd:. countyfips, statefips(}{it:stfips}{cmd:) countyfips(}{it:cofips}{cmd:)}{p_end}

{pstd}Merging with {cmd:statecode} and {cmd:countycode}{p_end}
{phang2}{cmd:. countyfips, statecode(}{it:stcode}{cmd:) countcode(}{it:cocode}{cmd:)}{p_end}

{pstd}By default, {cmd:countyfips} will generate a new variable, {cmd:_merge}, to indicate
the merged results.  If you do not want to create this variable, specify {cmd:nogenerate}.
This will keep matched observations and unmatched master observations.{p_end}

{phang2}{cmd:. countyfips, fips(}{it:county}{cmd:) nogenerate}{p_end}

{title:Limitations}
{pstd}Using {cmd:countyfips} with the {cmd:name} option requires specific
formatting of the {cmd:name} variable. County names must {it:not} include
"county" after the name. County names beginning with "Saint" such as
Saint Louis must be abbreviated to "St."{p_end}

{pstd}FIPS codes are available for U.S counties, county equivalents, and territories.
Census codes are only available for counties or county equivalents (such as independent cities).{p_end}

{pstd}FIPS codes for Virginia independent cities as well as merged county and
independent cities (as is the practice for some areas in BEA data) are
included. Using {cmd:countyfips} with the {cmd:name} option will require extremely
particular formatting. Additionally, only the {cmd:statefips} option will work
when merging with {cmd:name}.

{pstd}{cmd:countyfips} uses the more recent FIPS code for Miami-Dade county
(12086) rather than the FIPS code for Dade county (12025). The Census state
(10) and county (13) codes remain unchanged.

{title:Author}

{pstd}Christopher B. Goodman, School of Public Administration,
University of Nebraska at Omaha {p_end}
{pstd}{browse "mailto:cbgoodman@unomaha.edu":cbgoodman@unomaha.edu}{break} {p_end}

{title:Also see}

{pstd} {help statastates} (if installed)
