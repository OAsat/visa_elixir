ExUnit.start()
Mox.defmock(ExVisa.VisaMock, for: ExVisa.VisaBehaviour)
Application.put_env(:ex_visa, :listener_impl, ExVisa.VisaMock)
