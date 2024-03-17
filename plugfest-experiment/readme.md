# SBOM Landscape Experiment
Derek Garcia

Analyzed findings can be found in the final paper: [A Landscape Study of Open Source and Proprietary Tools for Software Bill of Materials (SBOM)](https://arxiv.org/abs/2402.11151)

## Quick Start
> Ensure Docker Daemon is running before running

**Run Scenario 1 ( Maven Available )**
```bash
./scenario1.sh
```

**Run Scenario 1 ( Maven Unavailable )**
```bash
./scenario1-no-mvn.sh
```

**Run Scenario 2**
```bash
./scenario2.sh
```

To learn more about details, see [Scenarios and Cases](readme.md#scenarios-and-cases)

## Plugfest Environment Image
To create a standardized testing environment, all tools use the custom `plugfest` image based off the 
`eclipse-temurin:21-jdk` image. The environment includes:

**Languages**
- Java 21
- Node LTS (20.11.0)[^1]

[^1]: Only used by CycloneDX Generator, but kept for consistency

**Package Managers**
- Maven[^1]
- NPM[^2]

[^1]: Only when using `plugfest-mvn` image

[^2]: Only used by CycloneDX Generator, but kept for consistency

**Utils**
- curl
- unzip
- git

Tools are installed in their respective image.

## Tools
> Tool Images can be found in the [docker](docker) directory.

|                                     **Tool**                                     |                        **Vendor**                         |       Image       |
|:--------------------------------------------------------------------------------:|:---------------------------------------------------------:|:-----------------:|
|            [CycloneDX Generator](https://github.com/CycloneDX/cdxgen)            |            [CycloneDX](https://cyclonedx.org/)            | cdxgen.Dockerfile |
|                     [Syft](https://github.com/anchore/syft)                      |              [Anchore](https://anchore.com/)              |  syft.Dockerfile  |
|                  [Trivy](https://github.com/aquasecurity/trivy)                  |         [Aqua Security](https://www.aquasec.com/)         | trivy.Dockerfile  |
|         [OSS Review Toolkit](https://github.com/oss-review-toolkit/ort)          | [OSS Review Toolkit](https://oss-review-toolkit.org/ort/) |  ort.Dockerfile   |
| [SPDX SBOM Generator](https://github.com/opensbom-generator/spdx-sbom-generator) |                        Independent                        |  spdx.Dockerfile  |

## Scenarios and Cases

### Scenarios
> Each scenario represents a different way to use same source code

**Scenario 1: Use Maven Build System**

Manage dependencies using maven.

**Scenario 2: Use native java**

Manage dependencies manually. Required jars have been included and scripts can be run inside the source directory using
```bash
java -classpath ../../../lib/* Main.java <arg>
# Example
java -classpath ../../../lib/* Main.java '{\"foo\":1}'
# Result: {"foo":2}
```

### Cases
> Each scenario uses the same use case

**Case 1: "As Intended"**

Dependencies are listed in the manifest file **AND** imported into the source file **AND** used.
>NOTE: Folder with all dependencies replace the manifest for scenario 2

**Case 2: "Dead Code"**

Dependencies are listed in the manifest file **AND** imported into the source file **BUT NOT** used.

**Case 3: "Manifest Only"**

Dependencies are listed in the manifest file **BUT NOT** imported into the source file **AND** used.
