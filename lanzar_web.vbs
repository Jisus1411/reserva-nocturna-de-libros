Set WShell = CreateObject("WScript.Shell")
WShell.Run "cmd.exe /c cd /d ""C:\Users\USER\Desktop\reto biblioteca\biblioteca_reservas"" && python main.py", 0, False
WShell.Run "http://127.0.0.1:5000/"