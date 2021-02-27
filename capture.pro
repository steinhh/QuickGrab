FUNCTION fake_linux_snapshot
  
END 
  

FUNCTION make_snapshot
  IF !version.os EQ "linux" THEN result = fake_linux_spawn() $
  ELSE spawn, "single_capture.sh", result, err_result
  parts = result.extract(': (.*)')
  print, ": " + parts
END

PRO capture
  cadence = 10 ; seconds
  WHILE 1 DO BEGIN
     filename = make_snapshot()
     make_thumbnail, filename
     wait, cadence
  END
END
