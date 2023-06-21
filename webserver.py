from cloudlink import cloudlink
cl = cloudlink()
cls = cl.server(logs=True)
cls.enable_logs = True
cls.run(ip = "localhost", port = 25565)