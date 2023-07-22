abstract class FkAsset {
  dynamic directory;
  FkAsset(this.directory);
}

abstract class FkAssetSnippetProvider {
  void setDirectory(String value);
}
