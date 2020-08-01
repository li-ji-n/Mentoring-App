List mentors = [
  {'id':1,'name': 'Abu'},
  {'id':2, 'name': 'Nissam'},
  {'id':3,'name': 'Rahul'},
  {'id':4,'name': 'Sreerag'},
  {'id':5,'name': 'Amrithlal'},
  {'id':6,'name': 'Vishnu'},
  {'id':7,'name': 'Murshid'}
];

List student = [
  {'id': 1, 'name': 'A', 'group': 7},
  {'id': 2, 'name': 'B', 'group': 7},
  {'id': 3, 'name': 'C', 'group': 6},
  {'id': 4, 'name': 'D', 'group': 7},
  {'id': 5, 'name': 'E', 'group': 8},
  {'id': 6, 'name': 'F', 'group': 7},
  {'id': 7, 'name': 'G', 'group': 8},
  {'id': 8, 'name': 'H', 'group': 5},
];

List studentMentorList = [
  {'name': 'A', 'mentor': 'Abu'},
  {'name': 'B', 'mentor': 'Nissam'},
  {'name': 'C', 'mentor': 'Amrithlal'},
  {'name': 'D', 'mentor': 'Nissam'},
  {'name': 'E', 'mentor': 'Rahul'},
  {'name': 'F', 'mentor': 'Abu'},
  {'name': 'G', 'mentor': 'Murshid'},
  {'name': 'H', 'mentor': 'Sreerag'},
];

List groups = [
  {
    'id': 1,
    'class': 'CSE A',
    'batch': 'S1/S2',
    'mentors': [],
  },
  {
    'id': 2,
    'class': 'CSE B',
    'batch': 'S1/S2',
    'mentors': [],
  },
  {
    'id': 3,
    'class': 'CSE A',
    'batch': 'S3/S4',
    'mentors': [],
  },
  {
    'id': 4,
    'class': 'CSE B',
    'batch': 'S3/S4',
    'mentors': [],
  },
  {
    'id': 5,
    'class': 'CSE A',
    'batch': 'S5/S6',
    'mentors': [],
  },
  {
    'id': 6,
    'class': 'CSE B',
    'batch': 'S5/S6',
    'mentors': [],
  },
  {
    'id': 7,
    'class': 'CSE A',
    'batch': 'S7/S8',
    'mentors': [{'id':1,'name': 'Abu'}, {'id':2,'name': 'Nissam'},{ 'id':3,'name': 'Amrithlal'}]
  },
  {
    'id': 8,
    'class': 'CSE B',
    'batch': 'S7/S8',
    'mentors': [{'id':4,'name': 'Rahul'}, {'id':5,'name': 'Sreerag'},{'id':6, 'name': 'Murshid'}]
  },
];

List classSection = [
  {'name': 'CSE A'},
  {'name': 'CSE B'},
];

List batch = [
  {'name': 'S1/S2'},
  {'name': 'S3/S4'},
  {'name': 'S5/S6'},
  {'name': 'S7/S8'},
];
