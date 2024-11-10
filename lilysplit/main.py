import argparse
import logging
from pathlib import Path
from subprocess import run

from .compiler import Compiler
from .song import LilySong
from .midicompiler import MidiCompiler
from .pdfcompiler import PdfCompiler
from .voicecompiler import VoiceCompiler

def gitdescribe(git_exe, git_opt, directory):
    return run([git_exe, '-C', directory, *git_opt], capture_output=True,
            text=True).stdout.strip()

def which(name):
    return Path(run(['which', name], capture_output=True, text=True).stdout.strip())

def split():
    parser = argparse.ArgumentParser()
    lilygroup = parser.add_argument_group('Lilypond execution')
    lilygroup.add_argument('--lily-exe', default=which('lilypond'), type=Path)
    lilygroup.add_argument('--lily-opts', nargs='*', action="extend", default=[])
    lilygroup.add_argument('--lily-code', nargs='*', action="extend", default=[])
    lilygroup.add_argument('--lily-loglevel', choices='NONE ERROR WARNING BASIC PROGRESS INFO DEBUG'.split(),
            default="WARNING")
    execgroup = parser.add_argument_group('Execution control')
    execgroup.add_argument('--color', action=argparse.BooleanOptionalAction, default=False, help="currently ignored")
    execgroup.add_argument('--log-level', choices='CRITICAL ERROR WARNING INFO DEBUG'.split(), default="INFO")
    gitgroup = parser.add_argument_group('Git execution')
    gitgroup.add_argument('--gitexe', default=which('git'), type=Path)
    gitgroup.add_argument('--gitopt', default='describe --tags --dirty --always'.split(), nargs='*')
    gitgroup.add_argument('--usegit', action=argparse.BooleanOptionalAction, default=True)
    parser.add_argument('--include-dir', type=Path, default=Path(__file__).parent / 'lib')
    parser.add_argument('--papersize', default="a4")
    parser.add_argument('--point_and_click', '--pac', action=argparse.BooleanOptionalAction,
            default=False)
    parser.add_argument('--midi-suffix', default='.midi')
    parser.add_argument('files', nargs='+', type=Path)
    args = parser.parse_args()

    logging.basicConfig(level=args.log_level)
    log = logging.getLogger("lilysplit")

    args.lily_opts.append('-dpoint-and-click' if args.point_and_click else '-dno-point-and-click')
    args.lily_opts.extend(['--include', str(args.include_dir)])
    args.lily_opts.extend(['--loglevel', args.lily_loglevel])
    args.lily_code.append(f'(define-public mypapersize "{args.papersize}")')

    if not args.lily_exe.exists():
        log.error("lilypond not found, please use --lily_exe /path/to/lilypond")
        raise SystemExit(1)
    Compiler.lily_exe = args.lily_exe

    if args.usegit:
        lilyver = gitdescribe(args.gitexe, args.gitopt, args.include_dir)
        args.lily_code.append(f'(define-public lilyver "{lilyver}")')

    versions = {}

    for song in args.files:
        with LilySong(song) as lilysong:
            log.info("Looking at %s", lilysong)
            if lilysong.directory not in versions:
                versions[lilysong.directory] = gitdescribe(args.gitexe, args.gitopt, lilysong.directory)
                log.info("%s is in new directory %s with git version %s",
                         lilysong, lilysong.directory, versions[lilysong.directory])

            lilycode = args.lily_code.copy()
            lilycode.append(f'(define-public gitver "{versions[lilysong.directory]}")')

            partc = PdfCompiler(lilysong, lilycode, args.lily_opts)
            partc.execute()
            lilysong.move('-', '.pdf')
            if partc.returncode != 0:
                raise SystemExit(partc.returncode)

            midic = MidiCompiler(lilysong, lilycode, args.lily_opts, midi_suffix=args.midi_suffix)
            midic.execute()
            lilysong.move('-midi', args.midi_suffix)
            if midic.returncode != 0:
                raise SystemExit(midic.returncode)

            lilycode.append('(define-public showAlle #f)')
            for voice in lilysong.voices:
                voicec = VoiceCompiler(lilysong, lilycode, args.lily_opts, voice=voice)
                voicec.execute()
                if voicec.returncode != 0:
                    raise SystemExit(voicec.returncode)
