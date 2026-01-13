#!/usr/bin/env python3

import nbformat
from typing import List
import glob
import sys


def add_custom_tags(filename: str, show_tags: List[str]):
    """
    指定されたファイルのJupyterノートブック内の各コードセルにカスタムタグを追加または更新する。

    Parameters
    ----------
    filename : str
        タグを更新するノートブックファイルのパス。
    show_tags : List[str]
        "hide-input" タグを適用する条件となる文字列のリスト。

    Notes
    -----
    セルに show_tags リスト内の任意の文字列が含まれている場合、そのセルには "hide-input" タグが設定される。
    それ以外のセルには "hide-cell" タグが設定される。
    """
    with open(filename, "r", encoding="utf-8") as file:
        notebook = nbformat.read(file, as_version=4)

    modified = False  # ノートブックが変更されたかどうかを追跡

    for cell in notebook.cells:
        if cell.cell_type == "code":
            # セルの内容に基づいてタグを設定
            if any(tag in cell.source for tag in show_tags):
                # 指定されたタグがセルに含まれている場合は、"hide-input" タグを設定
                if cell.metadata.get("tags", []) != ["hide-input"]:
                    cell.metadata["tags"] = ["hide-input"]
                    modified = True
            else:
                # それ以外の場合は "hide-cell" タグを設定
                if cell.metadata.get("tags", []) != ["hide-cell"]:
                    cell.metadata["tags"] = ["hide-cell"]
                    modified = True

    if modified:
        with open(filename, "w", encoding="utf-8") as file:
            nbformat.write(notebook, file)


def process_notebooks(path: str, show_tags: List[str]):
    """
    指定されたパスにあるすべてのJupyterノートブックに対してカスタムタグの追加処理を行う。

    Parameters
    ----------
    path : str
        処理するノートブックファイルがあるパス。
    show_tags : List[str]
        "hide-input" タグを適用する条件となる文字列のリスト。
    """
    for filename in glob.glob(path):
        add_custom_tags(filename, show_tags)


if __name__ == "__main__":
    # スクリプトを実行する際の初期設定
    #path = "./book/*/*.ipynb"  # デフォルトのパス
    path = "./book/*/*/*.ipynb"  # デフォルトのパス
    show_tags = [
        "# tag:show",
        "show_fig(",
    ]  # "hide-input" タグを適用するためのキーワード
    if len(sys.argv) > 1:
        path = sys.argv[1]  # コマンドライン引数からパスを取得
    process_notebooks(path, show_tags)
