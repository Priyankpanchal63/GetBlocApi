abstract class PostEvent{}

class PostFetched extends PostEvent{}

class SearchItem extends PostEvent{
  final String stSearch;
  SearchItem(this.stSearch);
}