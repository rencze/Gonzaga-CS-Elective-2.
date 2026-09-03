import 'package:flutter/material.dart';

import '../models/product.dart';

const List<Product> products = [
  Product(
    id: '1',
    name: 'Wireless Mouse',
    description: 'Compact wireless mouse for everyday work and study.',
    price: 1299,
    imageUrl: 'https://placehold.co/600x400/png?text=Mouse',
    icon: Icons.mouse_outlined,
  ),
  Product(
    id: '2',
    name: 'Mechanical Keyboard',
    description: 'Responsive mechanical keyboard for work and gaming.',
    price: 2499,
    imageUrl: 'https://placehold.co/600x400/png?text=Keyboard',
    icon: Icons.keyboard_outlined,
  ),
  Product(
    id: '3',
    name: 'Wireless Headphones',
    description: 'Comfortable wireless headphones for music and calls.',
    price: 1899,
    imageUrl: 'https://placehold.co/600x400/png?text=Headphones',
    icon: Icons.headphones_outlined,
  ),
  Product(
    id: '4',
    name: 'HD Webcam',
    description: 'HD webcam designed for classes, meetings, and streaming.',
    price: 1599,
    imageUrl: 'https://placehold.co/600x400/png?text=Webcam',
    icon: Icons.videocam_outlined,
  ),
  Product(
    id: '5',
    name: 'USB-C Hub',
    description: 'Multi-port USB-C hub for laptops and mobile devices.',
    price: 999,
    imageUrl: 'https://placehold.co/600x400/png?text=USB-C+Hub',
    icon: Icons.hub_outlined,
  ),
  Product(
    id: '6',
    name: 'Portable SSD',
    description: 'Fast portable storage for files, projects, and backups.',
    price: 3499,
    imageUrl: 'https://placehold.co/600x400/png?text=SSD',
    icon: Icons.storage_outlined,
  ),
];