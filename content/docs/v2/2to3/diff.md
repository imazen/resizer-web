Aliases: /docs/2to3/diff

# Differences between V2 and V3


1. V2 has no free version. V3 has a free version, but it does not include disk caching, octree quantization, dithering, or animated gif support. **Those features are included in the Performance Edition.**
2. V3 has a very slim 'core'. Extra functionality is added with plugins.
2. V3 is easy to extend without modifying the source code. V2 was designed for source code modification.
3. V3 is configured within the `<resizer />` element, not the `<appSettings />` element.
4. V3 has good default settings. Configuration is *optional*.
4. V3 has 48+ plugins. Plugins are easy to write, and can affect *any* aspect of the pipeline.
5. V3 makes URL rewriting easy.
6. V3 has a self-diagnostics page.
7. The V3 core is under [MIT-like license](/licenses/freedom), which is clearer and offers much more freedom than the 'V2' license.
8. Unlike V2, V3 has a clear (and permissive!) [license for enterprise use](/licenses/enterprise).
9. Version 3 offers disk caching and gif quantization as plugins, not in the core. This allows other kinds of caches to be installed, and also allows the core to be completely free and open-source while still providing a profit model for maintaining and improving the resizer.
