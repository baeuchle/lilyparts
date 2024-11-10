__copyright__ = "© CC-BY-SA 4.0 Bjørn Bäuchle, see file LICENSE"

from .pdfcompiler import PdfCompiler

class VoiceCompiler(PdfCompiler):
    def __init__(self, song, lilycode, lilyopts, voice):
        lilycode = lilycode.copy()
        lilycode.append(f'(define-public show{voice} #t)')
        super().__init__(song, lilycode, lilyopts)

