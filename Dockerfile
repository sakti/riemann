FROM python:3.10-slim as base

ENV PYTHONFAULTHANDLER=1 \
	PYTHONHASHSEED=random \
	PYTHONUNBUFFERED=1

WORKDIR /app

FROM base as builder

ENV PIP_DEFAULT_TIMEOUT=100 \
	PIP_DISABLE_PIP_VERSION_CHECK=1 \
	PIP_NO_CACHE_DIR=1

RUN apt-get update
RUN apt-get -y install build-essential libffi-dev libpq-dev python3-dev libjpeg-dev zlib1g-dev libc-dev make curl libfreetype6-dev

RUN pip install uv
RUN python -m venv /venv

COPY pyproject.toml uv.lock ./
RUN uv export --no-hashes | /venv/bin/pip install -r /dev/stdin

COPY . .
RUN uv build && /venv/bin/pip install dist/*.whl

FROM base as final
RUN apt-get update
RUN apt-get -y install --no-install-recommends libffi7 libpq5 libfreetype6-dev curl

EXPOSE 8000

COPY --from=builder /venv /venv
RUN /venv/bin/python -m riemann.setup --static
COPY docker-entrypoint.sh ./
# todo: use supervisord for multiple process (e.g: huey worker)
CMD ["./docker-entrypoint.sh"]
