# Provideous

Provideous is a command line application that will quickly create a one off video page. I use it to quickly create a page that I can drop on the web (or drop box for that matter) to share quick screen casts I've made with other remote team members. By default it uses [`videously`](https://github.com/knomedia/videously) to compress and normalize the video.

## Installation

Install it with:

```bash
$ gem install provideous
```

## Usage

### Creating a project

```bash
$ provideous projectname videofile
```

This will do the following:

* Create a directory named `projectname`
* Copy `videofile` into the directory
* Run `videously` on `videofile` to create an H.264 main profile, normalized audio version of the file (see note below)
* Create a screen-capture of `videofile` (at approx. 1 second) to use as a poster for the video
* Create a single, responsive page (using [`Zurb Foundation 3`](http://foundation.zurb.com/) )
* Create a filenamed `css/app.css` for you to customize the look of the page
* Open the page for you to preview

#### Videously note
Optionally you can pass `-s` as a third parameter. Doing so will skip the use of `videously` to compress and normalize the video. If you don't have `videously` installed, you will need to pass the `-s` and ensure your video is ready for the web.




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
