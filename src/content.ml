open Cow
open Printf
open Slides

let rt = ">>"

let header =[ {
  styles=[Title];
  content= <:xml<
   <h1>OCaml in the cloud</h1>
   <br />
   <b>building an open-source virtualization platform</b>
   <br />
   <br />
   Tech Mesh 2012, London
   <br />
   David Scott, XenServer System Architect, Citrix<br />
   <br />
       <a href="http://dave.recoil.org/">http://dave.recoil.org/</a> <br/>
        <a href="http://twitter.com/mugofsoup">@mugofsoup</a>
  >>;
}]

let footer = [{
  styles=[];
  content= <:xml<
    <h1>The End
    <br /><small>happy hacking</small>
    </h1>
  >>
}]
let articles = List.flatten [
  header;
  Intro.slides;
  footer;
]

let presentation = {
  topic="Ocaml in the cloud: building an open-source virtualization platform";
  layout=Regular;
  articles;
}

let body =
  let slides = Slides.slides presentation in
  printf "%d slides\n%!" (List.length articles);
  Xml.to_string slides
