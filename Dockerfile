# creamshi's own hermes computer image
# Fully decoupled from TunMax: base pinned to immutable digest.
# hermes-agent version baked in: v0.21.0 (commit 5d4aa4fc)
#
# To upgrade hermes-agent: change HERMES_REF to a new tag/commit SHA and push.
# Actions rebuilds automatically.

FROM ghcr.io/tunmax/openclaw_computer@sha256:a4f08fbe623bd48e9633f1dd6073dd2d25a661ba85622341ed11023cb6586420

ARG HERMES_REF="5d4aa4fc"
RUN cd /root/.hermes/hermes-agent \
    && git fetch origin \
    && git checkout --force "$HERMES_REF" \
    && ./venv/bin/pip install -e . --no-deps -q \
    && echo "Baked hermes-agent $HERMES_REF"

EXPOSE 7860
ENTRYPOINT ["/entrypoint.sh"]
