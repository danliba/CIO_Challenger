%%week to date %Retrieves the last day of the week, if you want the 1st day
%%then calculate weeks-1.
function date_w=week_to_date(yr,mo,da,weeks)
%weeks = [20 21 22 23];
t1 = datetime(yr, mo, da, 'Format', 'dd-MMMM-yyyy');  % First day of the year
date_w = t1 - days(weekday(t1)-1) + days((weeks).*7);