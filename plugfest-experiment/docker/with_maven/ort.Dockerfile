FROM plugfest:mvn

# Relative Project Path
ARG project_path

# Copy Source Code
COPY ${project_path} /code
RUN mkdir /out

# Install ort
WORKDIR /ort
RUN git clone https://github.com/oss-review-toolkit/ort .
RUN ./gradlew installDist

# Generate SBOM
CMD ["./cli/build/install/ort/bin/ort", "--info", "analyze", "-f", "JSON", "-i", "/code", "-o", "/out/ort-sbom.json"]
# docker run --rm --mount type=bind,source=out,target=/out -it test