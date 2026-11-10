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
  Product(
    id: '7',
    name: 'Bluetooth Speaker',
    description: 'Portable speaker with clear sound for your desk or travels.',
    price: 2199,
    imageAsset: 'lib/images/generated/bluetooth_speaker.png',
    category: 'Audio',
    details:
        'A compact Bluetooth speaker with a woven grille and simple top controls. Bring music, podcasts, and study playlists from your desk to another room.',
    highlights: ['Bluetooth audio', 'Portable design', 'Simple controls'],
    reviews: [],
    icon: Icons.speaker_outlined,
  ),
  Product(
    id: '8',
    name: 'Wireless Earbuds',
    description: 'Lightweight earbuds with a pocket-sized charging case.',
    price: 1799,
    imageAsset: 'lib/images/generated/wireless_earbuds.png',
    category: 'Audio',
    details:
        'A compact pair of true wireless earbuds with an easy-to-carry charging case for commutes, calls, and listening between classes.',
    highlights: ['True wireless fit', 'Charging case', 'Compact for travel'],
    reviews: [],
    icon: Icons.earbuds_outlined,
  ),
  Product(
    id: '9',
    name: 'USB Microphone',
    description:
        'Desktop condenser microphone for calls, classes, and recording.',
    price: 2899,
    imageAsset: 'lib/images/generated/usb_microphone.png',
    category: 'Audio',
    details:
        'A USB desktop microphone with a stable stand and accessible gain control for online classes, voice calls, and beginner recording setups.',
    highlights: ['USB connection', 'Desktop stand', 'On-device gain control'],
    reviews: [],
    icon: Icons.mic_none_outlined,
  ),
  Product(
    id: '10',
    name: 'Wireless Game Controller',
    description:
        'Comfortable wireless controller for PC and compatible devices.',
    price: 2499,
    imageAsset: 'lib/images/generated/wireless_controller.png',
    category: 'Gaming',
    details:
        'A familiar dual-stick wireless controller with responsive buttons for compatible PC games and supported devices.',
    highlights: ['Wireless play', 'Dual thumbsticks', 'Comfortable grip'],
    reviews: [],
    icon: Icons.sports_esports_outlined,
  ),
  Product(
    id: '11',
    name: 'Gaming Mouse',
    description:
        'Ergonomic mouse with responsive controls for gaming and work.',
    price: 1999,
    imageAsset: 'lib/images/generated/gaming_mouse.png',
    category: 'Gaming',
    details:
        'A comfortable gaming mouse with a contoured shape, responsive scroll wheel, and a subtle accent light for a coordinated desk setup.',
    highlights: ['Ergonomic shape', 'Responsive wheel', 'Accent lighting'],
    reviews: [],
    icon: Icons.mouse_outlined,
  ),
  Product(
    id: '12',
    name: 'Gaming Headset',
    description: 'Over-ear headset with a cushioned fit for long sessions.',
    price: 3299,
    imageAsset: 'lib/images/generated/gaming_headset.png',
    category: 'Gaming',
    details:
        'A cushioned over-ear headset designed for game audio, voice chat, and long sessions at your desk.',
    highlights: [
      'Over-ear cushions',
      'Adjustable headband',
      'Voice chat ready',
    ],
    reviews: [],
    icon: Icons.headphones_outlined,
  ),
  Product(
    id: '13',
    name: 'Portable Monitor',
    description: 'Slim secondary display for study, travel, and flexible work.',
    price: 7999,
    imageAsset: 'lib/images/generated/portable_monitor.png',
    category: 'Video',
    details:
        'A lightweight portable display that adds screen space beside a compatible laptop. The integrated kickstand helps position it on a desk or shared workspace.',
    highlights: [
      'Slim portable build',
      'Integrated kickstand',
      'Extra screen space',
    ],
    reviews: [],
    icon: Icons.monitor_outlined,
  ),
  Product(
    id: '14',
    name: 'Monitor Light Bar',
    description: 'Space-saving desk light that clips onto a monitor.',
    price: 1699,
    imageAsset: 'lib/images/generated/monitor_light_bar.png',
    category: 'Accessories',
    details:
        'A slim light bar that sits on top of a monitor to illuminate a keyboard and desk while keeping the base of your workspace clear.',
    highlights: [
      'Monitor-top mount',
      'Saves desk space',
      'Directional desk light',
    ],
    reviews: [],
    icon: Icons.lightbulb_outline,
  ),
  Product(
    id: '15',
    name: 'USB-C Docking Station',
    description: 'Connect your laptop to everyday wired accessories.',
    price: 2799,
    imageAsset: 'lib/images/generated/usb_c_dock.png',
    category: 'Accessories',
    details:
        'A compact aluminum docking station that gathers common USB accessories and displays around a laptop workspace. Check port and display compatibility for your device.',
    highlights: [
      'Multiple connection ports',
      'Compact aluminum body',
      'Laptop desk setup',
    ],
    reviews: [],
    icon: Icons.dock_outlined,
  ),
  Product(
    id: '16',
    name: '65W GaN Charger',
    description: 'Compact multi-port wall charger for compatible devices.',
    price: 1899,
    imageAsset: 'lib/images/generated/gan_charger.png',
    category: 'Accessories',
    details:
        'A compact multi-port wall charger for compatible phones, tablets, and laptops. Charging speed depends on the connected device and cable.',
    highlights: [
      '65W maximum output',
      'USB-C and USB-A ports',
      'Foldable plug',
    ],
    reviews: [],
    icon: Icons.electrical_services_outlined,
  ),
  Product(
    id: '17',
    name: '20,000mAh Power Bank',
    description: 'Portable battery for charging devices away from an outlet.',
    price: 2299,
    imageAsset: 'lib/images/generated/power_bank.png',
    category: 'Accessories',
    details:
        'A high-capacity portable battery with a clear charge indicator for keeping compatible devices powered while commuting or traveling.',
    highlights: ['20,000mAh capacity', 'Charge indicator', 'USB-C charging'],
    reviews: [],
    icon: Icons.battery_charging_full_outlined,
  ),
  Product(
    id: '18',
    name: 'Wi-Fi 6 Router',
    description: 'Modern wireless router for a connected home or study space.',
    price: 4499,
    imageAsset: 'lib/images/generated/wifi_router.png',
    category: 'Accessories',
    details:
        'A Wi-Fi 6 router with a compact upright body and multiple antennas for a home network. Coverage and speed vary with your internet plan, layout, and connected devices.',
    highlights: ['Wi-Fi 6 standard', 'Multi-antenna design', 'Home networking'],
    reviews: [],
    icon: Icons.router_outlined,
  ),
  Product(
    id: '19',
    name: 'Adjustable Laptop Stand',
    description: 'Raise your laptop for a more flexible desk setup.',
    price: 1899,
    imageAsset: 'lib/images/generated/laptop_stand.png',
    category: 'Accessories',
    details:
        'An adjustable aluminum stand lifts a laptop off the desk and helps free space for a keyboard and other accessories.',
    highlights: ['Adjustable angle', 'Aluminum frame', 'Folds for storage'],
    reviews: [],
    icon: Icons.laptop_mac_outlined,
  ),
  Product(
    id: '20',
    name: 'LED Ring Light',
    description: 'Desktop ring light for video calls and content recording.',
    price: 1299,
    imageAsset: 'lib/images/generated/ring_light.png',
    category: 'Video',
    details:
        'A compact ring light with a desktop tripod and phone holder for more even lighting during calls and recordings.',
    highlights: ['Desktop tripod', 'Phone holder', 'Even face lighting'],
    reviews: [],
    icon: Icons.light_mode_outlined,
  ),
  Product(
    id: '21',
    name: 'Drawing Tablet',
    description: 'Digital drawing surface with a separate pressure stylus.',
    price: 3799,
    imageAsset: 'lib/images/generated/drawing_tablet.png',
    category: 'Accessories',
    details:
        'A compact pen tablet for sketching, note taking, and digital illustration with compatible computer software.',
    highlights: [
      'Slim drawing surface',
      'Included stylus',
      'Creative workflows',
    ],
    reviews: [],
    icon: Icons.draw_outlined,
  ),
  Product(
    id: '22',
    name: 'Smartwatch',
    description: 'Everyday smartwatch with a comfortable sport band.',
    price: 3499,
    imageAsset: 'lib/images/generated/smartwatch.png',
    category: 'Mobile',
    details:
        'A modern smartwatch for checking notifications and everyday activity. Features depend on phone compatibility and device settings.',
    highlights: ['Digital watch face', 'Sport band', 'Notification support'],
    reviews: [],
    icon: Icons.watch_outlined,
  ),
  Product(
    id: '23',
    name: 'E-reader',
    description: 'Lightweight e-ink reader for books and study material.',
    price: 4999,
    imageAsset: 'lib/images/generated/ereader.png',
    category: 'Mobile',
    details:
        'A slim e-ink reading device for digital books and study material, designed for comfortable reading on the go.',
    highlights: ['E-ink display', 'Lightweight body', 'Portable reading'],
    reviews: [],
    icon: Icons.menu_book_outlined,
  ),
  Product(
    id: '24',
    name: 'USB Flash Drive',
    description: 'Compact USB storage for moving everyday files.',
    price: 799,
    imageAsset: 'lib/images/generated/usb_flash_drive.png',
    category: 'Storage',
    details:
        'A small USB flash drive with a swivel cover for carrying documents and transferring files between compatible devices.',
    highlights: ['USB 3.2 connection', 'Swivel cover', 'Pocket-sized storage'],
    reviews: [],
    icon: Icons.usb_outlined,
  ),
  Product(
    id: '25',
    name: 'USB Capture Card',
    description: 'Compact capture device for compatible HDMI sources.',
    price: 2299,
    imageAsset: 'lib/images/generated/capture_card.png',
    category: 'Video',
    details:
        'A compact capture device for connecting compatible HDMI equipment to a computer. Supported resolution and frame rate depend on the source and software.',
    highlights: ['HDMI input', 'USB connection', 'Streaming setups'],
    reviews: [],
    icon: Icons.video_camera_back_outlined,
  ),
  Product(
    id: '26',
    name: 'Laptop Cooling Pad',
    description: 'Ventilated stand with cooling fans for laptop desks.',
    price: 1499,
    imageAsset: 'lib/images/generated/cooling_pad.png',
    category: 'Accessories',
    details:
        'A ventilated laptop platform with fold-out supports and built-in fans to add airflow and a slight typing angle at a desk.',
    highlights: ['Mesh platform', 'Built-in fans', 'Fold-out supports'],
    reviews: [],
    icon: Icons.air_outlined,
  ),
  Product(
    id: '27',
    name: 'Two-Bay NAS Enclosure',
    description: 'Central home storage enclosure for two compatible drives.',
    price: 6999,
    imageAsset: 'lib/images/generated/nas_enclosure.png',
    category: 'Storage',
    details:
        'A compact two-bay network storage enclosure for compatible drives and home file sharing. Drives and setup are sold separately.',
    highlights: [
      'Two drive bays',
      'Network file storage',
      'Expandable capacity',
    ],
    reviews: [],
    icon: Icons.dns_outlined,
  ),
  Product(
    id: '28',
    name: 'Mechanical Number Pad',
    description: 'Separate number pad for faster desk-based data entry.',
    price: 1799,
    imageAsset: 'lib/images/generated/mechanical_numpad.png',
    category: 'Accessories',
    details:
        'A separate mechanical number pad that adds a dedicated numeric layout beside a compact keyboard.',
    highlights: [
      'Mechanical keys',
      'Separate numeric layout',
      'Compact footprint',
    ],
    reviews: [],
    icon: Icons.dialpad_outlined,
  ),
  Product(
    id: '29',
    name: 'Adjustable LED Desk Lamp',
    description: 'Articulating desk lamp with a warm LED light.',
    price: 1599,
    imageAsset: 'lib/images/generated/desk_lamp.png',
    category: 'Office',
    details:
        'An adjustable desk lamp with a weighted base and articulated arm for directing light over a study or work surface.',
    highlights: ['Adjustable arm', 'Stable round base', 'Warm LED light'],
    reviews: [],
    icon: Icons.desk_outlined,
  ),
  Product(
    id: '30',
    name: 'Mini Projector',
    description: 'Compact projector for a flexible home viewing setup.',
    price: 8999,
    imageAsset: 'lib/images/generated/mini_projector.png',
    category: 'Video',
    details:
        'A compact projector for compatible video sources and flexible viewing. Picture quality depends on room lighting, projection distance, and source content.',
    highlights: ['Compact body', 'Front-facing lens', 'Flexible placement'],
    reviews: [],
    icon: Icons.video_library_outlined,
  ),
  Product(
    id: '31',
    name: 'Flexible Phone Tripod',
    description: 'Bendable tabletop tripod with a universal phone clamp.',
    price: 999,
    imageAsset: 'lib/images/generated/phone_tripod.png',
    category: 'Accessories',
    details:
        'A flexible tabletop tripod with a phone clamp for calls, recording, and hands-free viewing on a desk.',
    highlights: ['Bendable legs', 'Phone clamp', 'Tabletop recording'],
    reviews: [],
    icon: Icons.phone_iphone_outlined,
  ),
];
