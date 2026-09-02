# creamshi's own hermes computer image
# Fully decoupled from TunMax: FROM pinned to immutable digest, not mutable :latest tag.
# GitHub Actions builds this and pushes to ghcr.io/creamshi0208/hermes-image:latest
#
# Future hermes upgrade: set HERMES_REF to a tag/commit of NousResearch/hermes-agent
# and push. Actions will rebuild on top of THIS pinned base.

FROM ghcr.io/tunmax/openclaw_computer@sha256:a4f08fbe623bd48e9633f1dd6073dd2d25a661ba85622341ed11023cb6586420

ARG HERMES_REF=""
RUN if [ -n "$HERMES_REF" ]; then \
      cd /root/.hermes/hermes-agent \
      && git fetch --depth 1 origin "$HERMES_REF" \
      && git checkout --force "$HERMES_REF" \
      && ./venv/bin/pip install -e . --no-deps -q \
      && echo "Baked hermes-agent $HERMES_REF"; \
    else \
      echo "No HERMES_REF set, keeping base image hermes version"; \
    fi

EXPOSE 7860
ENTRYPOINT ["/entrypoint.sh"]
