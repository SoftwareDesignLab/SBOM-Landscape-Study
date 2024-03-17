FROM plugfest:no-mvn

# Relative Project Path
ARG project_path

# Copy Source Code
COPY ${project_path} /code
RUN mkdir /out

# Install Syft
RUN curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

# Generate SBOM
CMD ["syft", "scan", "dir:/code", "-o", "syft-json=/out/syft-sbom.json"]
# docker run --rm --mount type=bind,source=out,target=/out -it test