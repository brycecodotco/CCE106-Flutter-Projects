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

List<Friend> friendList = [
  Friend(img: 'assets/images/user1.jpg', name: 'John Doe'),
  Friend(img: 'assets/images/user2.jpg', name: 'Jane Smith'),
  Friend(img: 'assets/images/user3.jpg', name: 'Alice Johnson'),
  Friend(img: 'assets/images/user4.jpg', name: 'Bob Brown'),
  Friend(img: 'assets/images/user5.jpg', name: 'Charlie Davis'),
  Friend(img: 'assets/images/user6.jpg', name: 'Emily Wilson'),
];



List<Usercomment> commentList = [
    Usercomment(
      commenterImg: 'assets/images/user1.jpg',
      commenterName: 'John Doe',
      commentTime: '2h ago',
      commentContent: 'This is a sample comment content',
    ),
    Usercomment(
      commenterImg: 'assets/images/user2.jpg',
      commenterName: 'Jane Smith',
      commentTime: '5h ago',
      commentContent: 'Another sample comment content',
    ),
    Usercomment(
      commenterImg: 'assets/images/user3.jpg',
      commenterName: 'Alice Johnson',
      commentTime: '1d ago',
      commentContent: 'Yet another sample comment content',
    ),
    Usercomment(
      commenterImg: 'assets/images/user4.jpg',
      commenterName: 'Bob Brown',
      commentTime: '2d ago',
      commentContent: 'Sample comment content from Bob',
    ),
  ];

  Account myUserAccount = Account(
    name: 'John Doe',
    email: 'john.doe@example.com',
    img: 'assets/images/user1.jpg',
    numFollowers: '100',
    numPosts: '50',
    numFollowing: '75',
    numFriends: '30',
  );

}

