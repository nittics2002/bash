BEGIN {
    r = 1
}
{
   _len = length($0)

   _splited[r] = ""
   _dq = 0

  for(i = 1; i <=_len; i++) {
    _ch = substr($0, i, 1)
      
    if (_ch == "\"" && _dq == 0) {
        _dq++
    } else if (_ch == "\"" && _dq == 1) {
        _splited[r] = _splited[r] _ch
        _dq = 0
    } else if (_dq == 1) {
        _splited[r] = _splited[r] "\"" _ch
        _dq = 0
    } else {
        _splited[r] = _splited[r] _ch
    } 
  }
  
  print _splited[r]
  r++;
}

