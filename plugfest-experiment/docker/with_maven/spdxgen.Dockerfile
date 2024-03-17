# NOTE: Maven is REQUIRED
FROM plugfest:mvn

# Relative Project Path
ARG project_path

# Copy Source Code
COPY ${project_path} /code
RUN mkdir /out

## Install spdx-sbom-generator
RUN curl -sL https://github.com/opensbom-generator/spdx-sbom-generator/releases/download/v0.0.15/spdx-sbom-generator-v0.0.15-linux-amd64.tar.gz | tar xz -C /bin

# Generate SBOM
WORKDIR /code
CMD ["spdx-sbom-generator", "-o", "/out"]
# docker run --rm --mount type=bind,source=out,target=/out -it test