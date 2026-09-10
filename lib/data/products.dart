import 'package:flutter/material.dart';

import '../models/product.dart';

const List<Product> products = [
  Product(
    id: '1',
    name: 'Wireless Mouse',
    description: 'Compact wireless mouse for everyday work and study.',
    price: 1299,
    imageAsset: 'lib/images/wireless_mouse.png',
    category: 'Accessories',
    details:
        'A compact mouse that keeps your desk free of extra cables. Its curved shape is easy to carry between classes, the library, and your workspace. A practical choice for browsing, documents, and everyday tasks.',
    highlights: ['Wireless connection', 'Compact shape', 'Everyday work'],
    reviews: [
      ProductReview(
        author: 'Alex',
        rating: 5,
        title: 'Easy to take to class',
        comment: 'Fits neatly in my laptop bag and keeps my desk tidy.',
      ),
      ProductReview(
        author: 'Sam',
        rating: 4,
        title: 'Good for daily tasks',
        comment:
            'Comfortable for browsing and assignments. I prefer a larger mouse for long gaming sessions.',
      ),
    ],
    icon: Icons.mouse_outlined,
  ),
  Product(
    id: '2',
    name: 'Mechanical Keyboard',
    description: 'Responsive mechanical keyboard for work and gaming.',
    price: 2499,
    imageAsset: 'lib/images/mechanical_keybaord.png',
    category: 'Accessories',
    details:
        'Bring a more tactile feel to your daily typing. This mechanical keyboard pairs a compact layout with a white and pink finish, making it a colorful addition to a study desk or gaming setup. Designed for writing, coding, and everyday play.',
    highlights: ['Mechanical keys', 'Compact layout', 'White and pink finish'],
    reviews: [
      ProductReview(
        author: 'Jamie',
        rating: 5,
        title: 'A nicer typing setup',
        comment: 'The keys feel satisfying when writing notes and code.',
      ),
      ProductReview(
        author: 'Casey',
        rating: 4,
        title: 'Love the colors',
        comment:
            'Looks great on my desk. The key sound may stand out in a quiet room.',
      ),
    ],
    icon: Icons.keyboard_outlined,
  ),
  Product(
    id: '3',
    name: 'Wireless Headphones',
    description: 'Comfortable wireless headphones for music and calls.',
    price: 1899,
    imageAsset: 'lib/images/wireless_headphone.png',
    category: 'Audio',
    details:
        'Enjoy music, lectures, and calls with an over-ear wireless design. Cushioned ear cups and an adjustable headband help you find a comfortable fit. A simple way to keep your listening setup free from trailing cables.',
    highlights: [
      'Wireless listening',
      'Over-ear design',
      'Adjustable headband',
    ],
    reviews: [
      ProductReview(
        author: 'Riley',
        rating: 5,
        title: 'Comfortable for lectures',
        comment:
            'The cushioned ear cups are comfortable during online classes.',
      ),
      ProductReview(
        author: 'Morgan',
        rating: 4,
        title: 'Useful every day',
        comment:
            'Easy to move around with while listening. They take more bag space than earbuds.',
      ),
    ],
    icon: Icons.headphones_outlined,
  ),
  Product(
    id: '4',
    name: 'HD Webcam',
    description: 'HD webcam designed for classes, meetings, and streaming.',
    price: 1599,
    imageAsset: 'lib/images/hd_webcam.png',
    category: 'Video',
    details:
        'Keep your camera setup ready for online classes, group meetings, and casual streaming. The compact webcam sits neatly at your workstation. Position it at eye level and use a well-lit space for clearer conversations.',
    highlights: ['HD video', 'Compact camera', 'Classes and meetings'],
    reviews: [
      ProductReview(
        author: 'Taylor',
        rating: 4,
        title: 'Good for class calls',
        comment:
            'A useful upgrade to my study setup when the room is well lit.',
      ),
      ProductReview(
        author: 'Jordan',
        rating: 4,
        title: 'Simple desk camera',
        comment: 'Compact enough to leave at my workstation between meetings.',
      ),
    ],
    icon: Icons.videocam_outlined,
  ),
  Product(
    id: '5',
    name: 'USB-C Hub',
    description: 'Multi-port USB-C hub for laptops and mobile devices.',
    price: 999,
    imageAsset: 'lib/images/usb-c_hub.png',
    category: 'Accessories',
    details:
        'Connect your everyday accessories through a compact USB-C hub. Its multi-port design keeps commonly used connections together, while the short attached cable fits neatly alongside a laptop. Check your device port support before use.',
    highlights: ['USB-C connection', 'Multiple ports', 'Portable design'],
    reviews: [
      ProductReview(
        author: 'Chris',
        rating: 5,
        title: 'Useful on a small desk',
        comment:
            'Keeps my accessories connected without spreading cables everywhere.',
      ),
      ProductReview(
        author: 'Avery',
        rating: 4,
        title: 'Handy to carry',
        comment:
            'Small enough for my bag. The attached cable is best for nearby devices.',
      ),
    ],
    icon: Icons.hub_outlined,
  ),
  Product(
    id: '6',
    name: 'Portable SSD',
    description: 'Fast portable storage for files, projects, and backups.',
    price: 3499,
    imageAsset: 'lib/images/portable_ssd.png',
    category: 'Storage',
    details:
        'Keep files, class projects, and backup copies close at hand with a compact external SSD. Its portable enclosure fits into a bag or desk drawer. A convenient storage companion when moving between study spaces and workstations.',
    highlights: ['Portable storage', 'Project backups', 'Compact enclosure'],
    reviews: [
      ProductReview(
        author: 'Alex',
        rating: 5,
        title: 'Handy for projects',
        comment: 'Easy to carry my project files between workspaces.',
      ),
      ProductReview(
        author: 'Sam',
        rating: 4,
        title: 'Practical backup storage',
        comment:
            'The compact case fits my bag well. I keep a second backup of important files.',
      ),
    ],
    icon: Icons.storage_outlined,
  ),
];
