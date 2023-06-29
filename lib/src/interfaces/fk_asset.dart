abstract class FkAsset {
  String directory;
  FkAsset(this.directory);
}

abstract class FkAssetSnippetProvider {
  void setDirectory(String value);
}
