import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="SmartBlindServer",
    version="0.0.1",
    author="Jason Hough",
    author_email="jason.hough01@utrgv.edu",
    description="",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/JasonFHough/utrgv-senior-project",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    entry_points={
        "console_scripts": [
            "run-server = SmartBlindServer.app:main"
        ]
    },
    python_requires=">=3.7",
)
