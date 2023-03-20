ExUnit.start()
Mox.defmock(ExVisa.VisaMock, for: ExVisa.Direct)
Application.put_env(:ex_visa, :visa_impl, ExVisa.VisaMock)
