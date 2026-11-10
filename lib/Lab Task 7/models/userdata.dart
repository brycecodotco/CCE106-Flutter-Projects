import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';
import 'account.dart';

class Userdata {
  List<Userpost> userList = [
    Userpost(
      userimg: 'assets/images/user1.jpg',
      username: 'John Doe',
      time: '2h ago',
      postcontent: 'This is a sample post content',
      postimg: 'assets/images/post1.jpg',
      numcomments: '5',
      numshare: '10',
      isLiked: false,
    ),
    Userpost(
      userimg: 'assets/images/user2.jpg',
      username: 'Jane Smith',
      time: '5h ago',
      postcontent: 'Another sample post content',
      postimg: 'assets/images/post2.jpg',
      numcomments: '10',
      numshare: '20',
      isLiked: true,
    ),
    Userpost(
      userimg: 'assets/images/user3.jpg',
      username: 'Alice Johnson',
      time: '1d ago',
      postcontent: 'Yet another sample post content',
      postimg: 'assets/images/post3.jpg',
      numcomments: '15',
      numshare: '30',
      isLiked: false,
    ),
    Userpost(
      userimg: 'assets/images/user4.jpg',
      username: 'Bob Brown',
      time: '2d ago',
      postcontent: 'Sample post content from Bob',
      postimg: 'assets/images/post4.jpg',
      numcomments: '8',
      numshare: '12',
      isLiked: true,
    ),
  ];
}