from riemann.settings import TIME_ZONE


def test_timezone():
    assert TIME_ZONE == "Asia/Jakarta"
