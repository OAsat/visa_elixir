ExUnit.start()
Mox.defmock(ExVisa.VisaMock, for: ExVisa.Direct)
Application.put_env(:ex_visa, :nif_visa, ExVisa.VisaMock)
