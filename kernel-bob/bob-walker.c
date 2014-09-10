// A Linux character device driver to emulate
// bob walker.
//
// See the accompanying README for instructions on loading
// as a kernel module.
//
// Heavily inspired by:
// http://www.tldp.org/LDP/lkmpg/2.4/html/c577.htm

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <asm/uaccess.h>  /* for put_user */
#include <asm/errno.h>

// Dual to avoid tainting the kernel's GPL license
MODULE_LICENSE("Dual MIT/GPL");

// Prototypes - this would normally go in a .h header file
int init_module(void);
void cleanup_module(void);
static int device_open(struct inode *, struct file *);
static int device_release(struct inode *, struct file *);
static ssize_t device_read(struct file *, char *, size_t, loff_t *);
static ssize_t device_write(struct file *, const char *, size_t, loff_t *);

#define SUCCESS 0
#define DEVICE_NAME "bob-walker" // As it appears in /proc/devices

// global variables
static int major_device_no;
static int device_use_count = 0;

static struct file_operations fops = {
        .read = device_read,
        .write = device_write,
        .open = device_open,
        .release = device_release
};

int init_module(void)
{
        major_device_no = register_chrdev(0, DEVICE_NAME, &fops);

        if (major_device_no < 0) {
                printk ("Registering the character device as major device number '%d' failed\n", major_device_no);
                return major_device_no;
        }

        printk("Hello, pesky human. This is the voice of bob, from the magical realm of kernel space.\n");
        printk("If you must bother me, try creating a device file:\n");
        printk("mknod /dev/bob-walker c %d 0\n", major_device_no);

        return 0;
}

void cleanup_module(void)
{
        // Unregister the device
        unregister_chrdev(major_device_no, DEVICE_NAME);
}

// Called when a process tries to open the device file, i.e.
// cat /dev/bob-walker
static int device_open(struct inode *inode, struct file *file)
{
        if (device_use_count) return -EBUSY;
        device_use_count++;

        return SUCCESS;
}

// Called when a process closes the device file
static int device_release(struct inode *inode, struct file *file)
{
        device_use_count--;

        return 0;
}

// Called when a process, which already opened the dev file, attempts to
// read from it.
static ssize_t device_read(struct file *filp,
                char *buffer,    // The buffer to fill with data
                size_t length,   // The length of the buffer
                loff_t *offset)  // Our offset in the file
{
        // Number of bytes actually written to the buffer
        int bytes_read = 0;

        char *bob_phrases = "beer\nbeard\npie\nsolaris\n";

        // Put the data into the buffer
        while (length && *bob_phrases)  {
                // The buffer is in the user data segment, not the kernel segment;
                // assignment won't work.  We have to use put_user which copies data from
                // the kernel data segment to the user data segment.
                put_user(*(bob_phrases++), buffer++);

                length--;
                bytes_read++;
        }

        return bytes_read;
}


//  Called when a process writes to dev file: echo "hi" > /dev/hello
static ssize_t device_write(struct file *filp,
                const char *buff,
                size_t len,
                loff_t *off)
{
        return -EINVAL;
}
