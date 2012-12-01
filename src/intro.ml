open Lwt
open Cow
open Printf
open Slides

let rt = ">>" (* required to embed it in html p4 as cant put that token directly there *)
let dl = "$"
let pres = "background-color:#ddddff"
let activity = "background-color:#ffdddd"
let rest = "background-color:#ddffdd"

let slides = [
(*
{
  styles=[];
  content= <:html<
    <h3>People</h3>
    <ul>
     <li><b>Dr. David Scott</b> (me!),<br />
       <div style="font-size: 80%">
       XenServer System Architect,<br />
       Citrix <br />
       www: <a href="http://dave.recoil.org/">http://dave.recoil.org</a>&nbsp; &nbsp; twitter: <a href="http://twitter.com/mugofsoup">mugofsoup</a>
       </div>
     </li>
	 <li>
	   <b>Dr. Richard Mortier</b>,<br />
       <div style="font-size: 80%">
       Horizon Transitional Fellow,<br />
       School of Computer Science, University of Nottingham.<br />
       www: <a href="http://www.cs.nott.ac.uk/~rmm/">http://www.cs.nott.ac.uk/~rmm</a>&nbsp; &nbsp; twitter: <a href="http://twitter.com/mort___">mort___</a>
       </div>
     </li>
     <li>
       <b>Dr. Anil Madhavapeddy</b>,<br />
       <div style="font-size: 80%">
       Senior Research Fellow,<br />
       Computer Laboratory, University of Cambridge.<br />
       www: <a href="http://anil.recoil.org/">http://anil.recoil.org</a>&nbsp; &nbsp; twitter: <a href="http://twitter.com/avsm">avsm</a>
       </div>
     </li>
    </ul>
    <p>With <b>lots</b> of help from Dr. Thomas Gazagnaire, Haris Rotsos, Raphael Proust and Balraj Singh.</p>

  >>
};
*)
{
  styles=[];
  content= <:html<
    <h3>What is XenServer?</h3>
    <ul>
      <li>a hypervisor platform</li>
      <li>based on open-source xen, Linux, CentOS</li>
      <li>turns a set of physical machines into a single, flexible substrate on which VMs can be installed, migrated around, etc etc</li>
      <li>runs just beneath a "cloud orchestration layer" which controls: users, service offerings, billing</li>
    </ul>
  >>;
};
{
  styles=[];
  content= <:html<
    <h3>Where did we put the OCaml?</h3>
    <p>Diagram</p>
  >>;
};
{
  styles=[];
  content= <:html<
    <h3>Why did we choose OCaml??!</h3>
    <ul>
    <li> We had:
      <ul>
      <li> a small team of smart, pragmatic people</li>
      <li> an existing codebase in C/C++/python</li>
      <li> ...</li>
      <li> too many defect tickets of the form "component X SIGSEGV (again)"</li>
      </ul>
    </li>

    </ul>
  >>;
};
{
  styles=[];
  content= <:html<
    <h3>Why did we choose OCaml??!</h3>
    <ul>
    <li> We knew we would spend too much time
      <ul>
      <li> tediously parsing strings (protocols, CLIs, config files)</li>
      <li> tracking down the root cause of memory corruption</li>
      </ul>
    </li>
    <li> We knew we would spend too little time
      <ul>
      <li> building features people wanted</li>
      <li> thinking about any kind of "design" at all</li>
      </ul>
    </li>
    </ul>
  >>;
};
{
  styles=[];
  content= <:html<
    <h3>Why did we choose OCaml??!</h3>
    <ul>
    <li> We knew we could <b>generate more value</b> by
      <ul>
      <li> using higher-level, safer tools</li>
      <li> thinking and planning more than one step ahead</li>
      </ul>
    </li>
    <li> .. but it's hard to justify anything that sounds like "rewrite" when
      <ul>
      <li> "the burn rate is X Mega USD per month"</li>
      <li> "we have a Y month runway"</li>
      </ul>
    </li>
    </ul>
  >>;
};
{
  styles=[];
  content= <:html<
    <h3>Why did we choose OCaml??!</h3>
    <ul>
    <li> we were asked to design a "hypervisor management API"
      <ul>
      <li> to manage all hosts within a "resource Pool" (cluster)</li>
      <li> for sysadmins, 3rd party integrators</li>
      <li> with language bindings in Java, C, C++</li>
      <li> with documentation</li>
      </ul>
    </li>
	<li> first task: create an API document for discussion</li>
    <li> why write a doc when you can generate from a declarative spec?</li>
    <li> .. and then you can genere code</li>
    </ul>
  >>;
};
{
  styles=[];
  content= <:html<
    <h3>Why did we choose OCaml??!</h3>
    <ul>
    <li> 3 of us had FP experience (standard ML)</li>
    <li> we knew that we could benefit from
    <ul>
      <li>type-checking</li>
      <li>bounds-checking</li>
    </ul>
    </li>
    <li> ocaml is like "a better C"
    <ul>
      <li> small, simple runtime (we described as "embedded")</li>
      <li> small memory footprint, quick startup time</li>
      <li> compiler generates decent native code</li>
      <li> FFI allows us to drop to C if necessary</li>
    </ul>
    </li>
    </ul>
  >>
};
{
  styles=[];
  content= <:html<
    <h3>but... but... what if you can't hire anyone?</h3>
<pre class="noprettyprint">
$str:dl$ git shortlog -s -n | dedup-users | wc -l
53
</pre>
    <section>
    <object data="lorenz.svg" type="image/svg+xml">&nbsp;</object>
    </section>
  >>
};
{
  styles=[];
  content= <:html<
    <h3>but... but... we won't be acquired if code is in ocaml!</h3>
    <ul>
      <li> maybe their devs will never understand the code?</li>
      <ul>
        <li> honestly ocaml is the easy bit; hypervisors are quite complex</li>
      </ul>
      <li> but the code is insecure: you can't run off-the-shelf buffer overflow detectors</li>
      <ul>
        <li> perhaps this did put some people off: probably a lucky escape</li>
      </ul>
    </ul>
    <center><b> In 2007 Citrix bought XenSource for 500 M USD</b></center>
  >>
};

{
  styles=[];
  content= <:html<
    <h3>Mirage: the other way</h3>
    <ul>
	  <li><b>&quot;The cloud is the computer&quot;</b>: now we only need simple block, network packet abstractions at the bottom.</li>
      <li>Protocol libraries, rather than layers
        <ul>
          <li> IP, UDP, TCP, HTTP, DNS, SSH, FAT32, OpenFlow </li>
          <li> <a href="http://github.com/mirage/">http://github.com/mirage/</a></li>
        </ul>
      </li>
      <li>Modules, signatures, functors, recompilation rather than ABIs
        <ul>
          <li> Type-checker helps with API updates </li>
        </ul>
      </li>
      <li>Single-purpose, optimised, statically-linked images running as OS kernels
        <ul>
          <li> Fetch libraries with <b>opam</b> </li>
          <li> Link only what you need </li>
          <li> Compile-in static configuration (no config files) </li>
        </ul>
      </li>
    </ul>
  >>
};
{ styles=[];
  content= <:html<
    <h3>Example: xenstore service</h3>
    <ul>
      <li>A critical service on a <tt>xen</tt> host, needed by all control operations.</li>
      <li>Provides an access-controlled key-value store to all VMs.</li>
    </ul>
    <section>
    <object data="xenstore.svg" type="image/svg+xml">&nbsp;</object>
    </section>
  >>
};
{ styles=[];
  content= <:html<
    <h3>Example: this presentation</h3>
    <section>
    <object data="website.svg" type="image/svg+xml">&nbsp;</object>
    </section>
  >>
};
{ styles=[];
  content= <:html<
    <h3>Performance: block I/O</h3>
    <section>
    <object data="storage-colour.svg" type="image/svg+xml">&nbsp;</object>
    </section>
  >>
};
{ styles=[];
  content= <:html<
    <h3>Performance: network I/O</h3>
    <section>
    <object data="dns-qps.svg" type="image/svg+xml">&nbsp;</object>
    </section>
  >>
};
{ styles=[];
  content= <:html<
    <h3>Binary size</h3>
    <p>All binaries are bzip2'd (since they're sparse, with lots of blocks of zero)</p>
    <table>
      <tr style="background-color:#000; color:#EEE"><td>App</td><td>standard build / KiB</td><td>with dead code elim / KiB</td></tr>
      <tr style=$str:rest$><td>DNS</td><td>499</td><td>184</td></tr>
      <tr style=$str:activity$><td>web server</td><td>674</td><td>172</td></tr>
      <tr style=$str:rest$><td>OpenFlow learning switch</td><td>393</td><td>164</td></tr>
      <tr style=$str:activity$><td>OpenFlow controller</td><td>392</td><td>168</td></tr>
    </table>
    <p>Dead code elimination currently only possible on bytecode (via <tt>ocamlclean</tt>).</p>
    <p><b>Remember: these binaries are self-contained, containing full network stacks etc.</b></p>
  >>
};
{ styles=[];
  content= <:html<
    <h3>Building</h3>
      <p>Set up <b>opam</b></p>
<pre class="noprettyprint">
$str:dl$ git clone https://github.com/OCamlPro/opam
$str:dl$ (cd opam &amp;&amp; ./configure &amp;&amp; make &amp;&amp; make install)
$str:dl$ opam init default git://github.com/mirage/opam-repository
$str:dl$ opam remote -add dev git://github.com/mirage/opam-repo-dev
</pre>
     <p>Switch to xen and install mirage</p>
<pre class="noprettyprint">
$str:dl$ opam switch -install 3.12.1+mirage-xen
$str:dl$ opam switch 3.12.1+mirage-xen
$str:dl$ opam --yes install mirage mirage-net cohttp mirage-fs
</pre>
     <p>You're ready to go!</p>
  >>
};
{ styles=[];
  content= <:html<
    <h3>Summary</h3>
    <ul>
      <li>Building apps with mirage is liberating and fun
        <ul>
          <li>I even enjoyed debugging the TCP stack last weekend</li>
          <li>It makes kernel programming less of a &quot;black art&quot;</li>
        </ul>
      </li>
      <li>Give <b>opam</b> a try</li>
      <li>Be explicit about the interfaces your app needs: do you need all of Unix or just a network stack?
        <ul>
          <li> As well as being mirage-friendly, this also makes your app easier to test through &quot;mocks&quot;</li>
        </ul>
      </li>
    </ul>
  >>
};
]
