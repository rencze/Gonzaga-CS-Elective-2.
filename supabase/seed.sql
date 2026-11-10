create table if not exists public.products (
  id bigint primary key,
  name text not null,
  description text not null,
  price numeric(10, 2) not null check (price >= 0),
  image_asset text not null,
  category text not null,
  details text not null,
  highlights text[] not null default '{}'
);

alter table public.products enable row level security;
drop policy if exists "Products are readable by app users" on public.products;
create policy "Products are readable by app users"
  on public.products for select to anon, authenticated using (true);
grant usage on schema public to anon, authenticated;
grant select on public.products to anon, authenticated;

insert into public.products
  (id, name, description, price, image_asset, category, details, highlights)
values
  (1, 'Wireless Mouse', 'Compact wireless mouse for everyday work and study.', 1299, 'lib/images/wireless_mouse.png', 'Accessories', 'A compact mouse that keeps your desk free of extra cables. Its curved shape is easy to carry between classes, the library, and your workspace.', array['Wireless connection', 'Compact shape', 'Everyday work']),
  (2, 'Mechanical Keyboard', 'Responsive mechanical keyboard for work and gaming.', 2499, 'lib/images/mechanical_keybaord.png', 'Accessories', 'A tactile mechanical keyboard with a compact layout for writing, coding, and everyday play.', array['Mechanical keys', 'Compact layout', 'White and pink finish']),
  (3, 'Wireless Headphones', 'Comfortable wireless headphones for music and calls.', 1899, 'lib/images/wireless_headphone.png', 'Audio', 'Enjoy music, lectures, and calls with an over-ear wireless design and cushioned ear cups.', array['Wireless listening', 'Over-ear design', 'Adjustable headband']),
  (4, 'HD Webcam', 'HD webcam designed for classes, meetings, and streaming.', 1599, 'lib/images/hd_webcam.png', 'Video', 'A compact webcam for online classes, group meetings, and casual streaming.', array['HD video', 'Compact camera', 'Classes and meetings']),
  (5, 'USB-C Hub', 'Multi-port USB-C hub for laptops and mobile devices.', 999, 'lib/images/usb-c_hub.png', 'Accessories', 'Connect everyday accessories through a compact USB-C hub.', array['USB-C connection', 'Multiple ports', 'Portable design']),
  (6, 'Portable SSD', 'Fast portable storage for files, projects, and backups.', 3499, 'lib/images/portable_ssd.png', 'Storage', 'Keep class projects and backup copies close at hand with a compact external SSD.', array['Portable storage', 'Project backups', 'Compact enclosure']),
  (7, 'Bluetooth Speaker', 'Portable speaker with clear sound for your desk or travels.', 2199, 'lib/images/generated/bluetooth_speaker.png', 'Audio', 'A compact Bluetooth speaker with a woven grille and simple top controls for music, podcasts, and study playlists.', array['Bluetooth audio', 'Portable design', 'Simple controls']),
  (8, 'Wireless Earbuds', 'Lightweight earbuds with a pocket-sized charging case.', 1799, 'lib/images/generated/wireless_earbuds.png', 'Audio', 'A compact pair of true wireless earbuds with an easy-to-carry charging case for commutes, calls, and listening between classes.', array['True wireless fit', 'Charging case', 'Compact for travel']),
  (9, 'USB Microphone', 'Desktop condenser microphone for calls, classes, and recording.', 2899, 'lib/images/generated/usb_microphone.png', 'Audio', 'A USB desktop microphone with a stable stand and accessible gain control for online classes, voice calls, and beginner recording setups.', array['USB connection', 'Desktop stand', 'On-device gain control']),
  (10, 'Wireless Game Controller', 'Comfortable wireless controller for PC and compatible devices.', 2499, 'lib/images/generated/wireless_controller.png', 'Gaming', 'A familiar dual-stick wireless controller with responsive buttons for compatible PC games and supported devices.', array['Wireless play', 'Dual thumbsticks', 'Comfortable grip']),
  (11, 'Gaming Mouse', 'Ergonomic mouse with responsive controls for gaming and work.', 1999, 'lib/images/generated/gaming_mouse.png', 'Gaming', 'A comfortable gaming mouse with a contoured shape, responsive scroll wheel, and a subtle accent light for a coordinated desk setup.', array['Ergonomic shape', 'Responsive wheel', 'Accent lighting']),
  (12, 'Gaming Headset', 'Over-ear headset with a cushioned fit for long sessions.', 3299, 'lib/images/generated/gaming_headset.png', 'Gaming', 'A cushioned over-ear headset designed for game audio, voice chat, and long sessions at your desk.', array['Over-ear cushions', 'Adjustable headband', 'Voice chat ready']),
  (13, 'Portable Monitor', 'Slim secondary display for study, travel, and flexible work.', 7999, 'lib/images/generated/portable_monitor.png', 'Video', 'A lightweight portable display that adds screen space beside a compatible laptop. The integrated kickstand helps position it on a desk or shared workspace.', array['Slim portable build', 'Integrated kickstand', 'Extra screen space']),
  (14, 'Monitor Light Bar', 'Space-saving desk light that clips onto a monitor.', 1699, 'lib/images/generated/monitor_light_bar.png', 'Accessories', 'A slim light bar that sits on top of a monitor to illuminate a keyboard and desk while keeping the base of your workspace clear.', array['Monitor-top mount', 'Saves desk space', 'Directional desk light']),
  (15, 'USB-C Docking Station', 'Connect your laptop to everyday wired accessories.', 2799, 'lib/images/generated/usb_c_dock.png', 'Accessories', 'A compact aluminum docking station that gathers common USB accessories and displays around a laptop workspace. Check port and display compatibility for your device.', array['Multiple connection ports', 'Compact aluminum body', 'Laptop desk setup']),
  (16, '65W GaN Charger', 'Compact multi-port wall charger for compatible devices.', 1899, 'lib/images/generated/gan_charger.png', 'Accessories', 'A compact multi-port wall charger for compatible phones, tablets, and laptops. Charging speed depends on the connected device and cable.', array['65W maximum output', 'USB-C and USB-A ports', 'Foldable plug']),
  (17, '20,000mAh Power Bank', 'Portable battery for charging devices away from an outlet.', 2299, 'lib/images/generated/power_bank.png', 'Accessories', 'A high-capacity portable battery with a clear charge indicator for keeping compatible devices powered while commuting or traveling.', array['20,000mAh capacity', 'Charge indicator', 'USB-C charging']),
  (18, 'Wi-Fi 6 Router', 'Modern wireless router for a connected home or study space.', 4499, 'lib/images/generated/wifi_router.png', 'Accessories', 'A Wi-Fi 6 router with a compact upright body and multiple antennas for a home network. Coverage and speed vary with your internet plan, layout, and connected devices.', array['Wi-Fi 6 standard', 'Multi-antenna design', 'Home networking']),
  (19, 'Adjustable Laptop Stand', 'Raise your laptop for a more flexible desk setup.', 1899, 'lib/images/generated/laptop_stand.png', 'Accessories', 'An adjustable aluminum stand lifts a laptop off the desk and helps free space for a keyboard and other accessories.', array['Adjustable angle', 'Aluminum frame', 'Folds for storage']),
  (20, 'LED Ring Light', 'Desktop ring light for video calls and content recording.', 1299, 'lib/images/generated/ring_light.png', 'Video', 'A compact ring light with a desktop tripod and phone holder for more even lighting during calls and recordings.', array['Desktop tripod', 'Phone holder', 'Even face lighting']),
  (21, 'Drawing Tablet', 'Digital drawing surface with a separate pressure stylus.', 3799, 'lib/images/generated/drawing_tablet.png', 'Accessories', 'A compact pen tablet for sketching, note taking, and digital illustration with compatible computer software.', array['Slim drawing surface', 'Included stylus', 'Creative workflows']),
  (22, 'Smartwatch', 'Everyday smartwatch with a comfortable sport band.', 3499, 'lib/images/generated/smartwatch.png', 'Mobile', 'A modern smartwatch for checking notifications and everyday activity. Features depend on phone compatibility and device settings.', array['Digital watch face', 'Sport band', 'Notification support']),
  (23, 'E-reader', 'Lightweight e-ink reader for books and study material.', 4999, 'lib/images/generated/ereader.png', 'Mobile', 'A slim e-ink reading device for digital books and study material, designed for comfortable reading on the go.', array['E-ink display', 'Lightweight body', 'Portable reading']),
  (24, 'USB Flash Drive', 'Compact USB storage for moving everyday files.', 799, 'lib/images/generated/usb_flash_drive.png', 'Storage', 'A small USB flash drive with a swivel cover for carrying documents and transferring files between compatible devices.', array['USB 3.2 connection', 'Swivel cover', 'Pocket-sized storage']),
  (25, 'USB Capture Card', 'Compact capture device for compatible HDMI sources.', 2299, 'lib/images/generated/capture_card.png', 'Video', 'A compact capture device for connecting compatible HDMI equipment to a computer. Supported resolution and frame rate depend on the source and software.', array['HDMI input', 'USB connection', 'Streaming setups']),
  (26, 'Laptop Cooling Pad', 'Ventilated stand with cooling fans for laptop desks.', 1499, 'lib/images/generated/cooling_pad.png', 'Accessories', 'A ventilated laptop platform with fold-out supports and built-in fans to add airflow and a slight typing angle at a desk.', array['Mesh platform', 'Built-in fans', 'Fold-out supports']),
  (27, 'Two-Bay NAS Enclosure', 'Central home storage enclosure for two compatible drives.', 6999, 'lib/images/generated/nas_enclosure.png', 'Storage', 'A compact two-bay network storage enclosure for compatible drives and home file sharing. Drives and setup are sold separately.', array['Two drive bays', 'Network file storage', 'Expandable capacity']),
  (28, 'Mechanical Number Pad', 'Separate number pad for faster desk-based data entry.', 1799, 'lib/images/generated/mechanical_numpad.png', 'Accessories', 'A separate mechanical number pad that adds a dedicated numeric layout beside a compact keyboard.', array['Mechanical keys', 'Separate numeric layout', 'Compact footprint']),
  (29, 'Adjustable LED Desk Lamp', 'Articulating desk lamp with a warm LED light.', 1599, 'lib/images/generated/desk_lamp.png', 'Office', 'An adjustable desk lamp with a weighted base and articulated arm for directing light over a study or work surface.', array['Adjustable arm', 'Stable round base', 'Warm LED light']),
  (30, 'Mini Projector', 'Compact projector for a flexible home viewing setup.', 8999, 'lib/images/generated/mini_projector.png', 'Video', 'A compact projector for compatible video sources and flexible viewing. Picture quality depends on room lighting, projection distance, and source content.', array['Compact body', 'Front-facing lens', 'Flexible placement']),
  (31, 'Flexible Phone Tripod', 'Bendable tabletop tripod with a universal phone clamp.', 999, 'lib/images/generated/phone_tripod.png', 'Accessories', 'A flexible tabletop tripod with a phone clamp for calls, recording, and hands-free viewing on a desk.', array['Bendable legs', 'Phone clamp', 'Tabletop recording'])
on conflict (id) do update set
  name = excluded.name,
  description = excluded.description,
  price = excluded.price,
  image_asset = excluded.image_asset,
  category = excluded.category,
  details = excluded.details,
  highlights = excluded.highlights;
