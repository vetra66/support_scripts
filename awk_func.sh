#!/bin/awk -f
# Print 1 second summary of auditlog commands
BEGIN { prev_sec=0; prev_line="" }
{
  gsub(",.*$", "", $2)
  m=split($2, t, ":") 
  sec=t[1]*3600 + t[2]*60 + t[3]
  if (prev_sec != 0) {
    if (sec - prev_sec > 10) {
      printf "----\n"
      print prev_line
      print $0
    }
  }
  prev_sec=sec
  prev_line=$0
}
END {
}
#!/bin/awk -f
# Print 1 second summary of auditlog commands
BEGIN { prev_sec=0; prev_line="" }
{
  if (match($0, /^[0-9]{4}/)) {
    gsub(",.*$", "", $2)
    m=split($2, t, ":") 
    sec=t[1]*3600 + t[2]*60 + t[3]
    if (prev_sec != 0) {
      if (sec - prev_sec > 10) {
        printf "----\n"
        print prev_line
        print $0
      }
    }
    prev_sec=sec
    prev_line=$0
  }
}
END {
}
