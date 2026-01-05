#!/usr/bin/env python3
"""
Transcritor de Áudio usando OpenAI Whisper
Transcreve todos os arquivos .ogg da pasta Downloads.
"""

import os
import sys
from pathlib import Path
import glob


def transcrever_arquivo(model, arquivo_path, lingua="pt"):
    """Transcreve um único arquivo de áudio."""
    print(f"\nTranscrevendo: {arquivo_path.name}")
    print("-" * 50)

    # Transcrever
    result = model.transcribe(
        str(arquivo_path),
        language=lingua,
        fp16=False
    )

    texto = result["text"].strip()

    # Exibir na tela
    print(texto)
    print("-" * 50)

    # Criar arquivo de texto com mesmo nome
    saida = arquivo_path.with_suffix(".txt")
    with open(saida, "w", encoding="utf-8") as f:
        f.write(texto)

    print(f"Salvo em: {saida}")
    print(f"Duração: {result.get('duration', 0):.1f} segundos")

    return texto


def main():
    # Pasta Downloads
    downloads = Path.home() / "Downloads"

    # Buscar todos os arquivos .ogg
    arquivos_ogg = list(downloads.glob("*.ogg"))

    if not arquivos_ogg:
        print(f"Nenhum arquivo .ogg encontrado em: {downloads}")
        sys.exit(0)

    print(f"Found {len(arquivos_ogg)} arquivo(s) .ogg em: {downloads}")

    # Importar whisper do ambiente virtual
    import whisper

    print("Carregando modelo Whisper 'base'...")
    model = whisper.load_model("base")

    # Transcrever cada arquivo
    for arquivo in arquivos_ogg:
        try:
            transcrever_arquivo(model, arquivo, lingua="pt")
        except Exception as e:
            print(f"Erro ao transcrever {arquivo.name}: {e}", file=sys.stderr)

    print("\n✓ Transcrição concluída!")


if __name__ == "__main__":
    main()
