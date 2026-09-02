# creamshi 的自有 hermes 镜像
# 由 GitHub Actions 构建，推送到 ghcr.io/<你的GitHub用户名>/hermes-image
# 这个镜像是自包含的；ModelScope studio 的 Dockerfile 只需要 FROM 这个镜像。
#
# 当前 Phase 1：直接复用基础镜像（获取主权——TunMax 改/删他的 tag 与你无关）
# 未来升级 hermes 时：取消下面 HERMES_REF 的注释，填入你要锁定的版本 tag，
# GitHub Actions 会在构建时拉取该版本并烘焙进镜像。

FROM ghcr.io/tunmax/openclaw_computer:hermes_latest

# ── 可选：烘焙指定 hermes-agent 版本（留空=保持基础镜像版本）──
# 设了就在 GitHub Actions 上拉取该 tag/commit 并刷新 venv 注册
# 例：HERMES_REF=v0.16.0  或  HERMES_REF=main
ARG HERMES_REF=""
RUN if [ -n "$HERMES_REF" ]; then \
      cd /root/.hermes/hermes-agent \
      && git fetch --depth 1 origin "$HERMES_REF" \
      && git checkout --force "$HERMES_REF" \
      && ./venv/bin/pip install -e . --no-deps -q \
      && echo "已烘焙 hermes-agent $HERMES_REF"; \
    else \
      echo "未设 HERMES_REF，保持基础镜像 hermes 版本"; \
    fi

EXPOSE 7860
ENTRYPOINT ["/entrypoint.sh"]
