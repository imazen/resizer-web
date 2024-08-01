

## State of ImageResizer documentation
We currently generate static sites with Doxygen and docu. Our main docs are a site populated with markdown and slim (> 100 pages). Generated docs live on separate subdomains, are generated infrequently, not versioned, and not integrated with the main docs except by 1 hyperlink.

We currently maintain 1 version of the docs, and annotate differences between versions. This is no longer maintainable. 

We embed sample code, but have no automated process to verify that it compiles against the version of our APIs the docs correspond with.

We need to maintain comprehensive docs on GitHub itself, in the form of markdown files in the repository root, but we really need to DRY out our docs, not introduce more duplication. Docs are 2/3rds of our cost.

## Goals

DRY, Version, Test, don't restrict to published versions. Update past versions of docs.

1. Easily version *some* docs with the code, in the same repository; specifically, in README.md and other files. This subset of docs includes getting started info, along with docs tied to extensibility or other internal behavior that can differ between major versions.
2. Version other docs separately, and use annotations. This subset of docs should apply to all product versions, and sees more maintenance.
3. Have generated documentation happen with every commit, on every branch, and focus on 'exploring the code, data paths, and structure' of the app rather than presenting an arbitrary TOC of classes and members. 
4. Embed code samples from related git repositories; such as external sample projects. Let them run CI to verify correctnes of the sample code. No more untested samples.
5. Present all of this is a single, linear website, with a version switcher. Navigation through every piece of documentation, examples, and code commentary should be possible from a single accordion or tree.
6. Make this efficient, and possible from Travis or a $5 server.

## Solution structure for multi-repo projects

Given a set of related git repositories which comprise the sum of input, 1 repo and 1 branch shall be designated as holding the authoritative configuration file(s), and  that repo location+branch name will be present in a webhook URL added to all repos.

This configuration file shall list all git sources, and shall correlate branches betwen repositories, such that for every branch and version exposed to the viewer, a specific branch, tag, or commit can be calculated for every member repository.

For simplicity, a semver shall be used to connect public labels with source versions.

sources:
    - imazen/resizer-web 
    - imazen/resizer
    - imazen/resizer-sample-gallery
    - imazen/slimmage
    - imazen/libwebp-net
    - imazen/n-metadata-extractor
    - imazen/studiojs
    - imazen/slimresponse


visible_versions:
    repo: resizer
    branches:
        - develop (v4 nightly) [v4]
        - support/v3 (v3 stable) [v3.4]
        - support/v4 (v4 stable) [v4]
        - support/v2 (v2 stable) [v2]
        - features/* [v4]
    tags: 
        - resizer-3-4-3.105 (v3.4.3) [v3.4]

dependencies:
    v2: 
        resizer-web: support/v2
    v3: 
      resizer-web: master
      slimmage: master
      libwebp-net: support/v2
      studiojs: master
      slimresponse: master
    v4: 
      libwebp-net: master
      n-metadata-extractor: master        
      resizer-sample-gallery: master


## Solution structure for single-repo projects

sources:
    - imazen/n-metadata-extractor

visible_versions:
    repo: imazen/resizer
    branches:
        - develop (v4 nightly) [v4]
        - support/v3 (v3 stable) [v3.4]
        - support/v4 (v4 stable) [v4]
        - support/v2 (v2 stable) [v2]
        - features/* [v4]
    tags: 
        - resizer-3-4-3.105 (v3.4.3) [v3.4]





## Assumptions

* There are no repositories with conflicting names in the same build
* 