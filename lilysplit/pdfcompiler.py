from .compiler import Compiler

class PdfCompiler(Compiler):
    def __init__(self, song, lilycode, lilyopts):
        lilyopts = lilyopts.copy()
        lilyopts.append('-dmidi-extension=midirm')
        super().__init__(song, lilycode, lilyopts)

