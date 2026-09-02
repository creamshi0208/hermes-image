# creamshi's own hermes computer image
# Fully decoupled from TunMax: base pinned to immutable digest.
# hermes-agent v0.21.0 is baked into the base image venv (no pip present).
#
# UPGRADE NOTE: To upgrade hermes-agent, the base image must be rebuilt
# with the new version (change digest below). Just changing HERMES_REF
# won't work because the build env has no pip.

FROM ghcr.io/tunmax/openclaw_computer@sha256:a4f08fbe623bd48e9633f1dd6073dd2d25a661ba85622341ed11023cb6586420

ARG HERMES_REF="5d4aa4fc"
RUN cd /root/.hermes/hermes-agent \
    && git fetch origin \
    && git reset --hard "$HERMES_REF" \
    && echo "Code at $HERMES_REF (venv already has matching version)"

EXPOSE 7860
ENTRYPOINT ["/entrypoint.sh"]
