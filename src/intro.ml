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
    <h3>Talk structure</h3>
    <ol>
    <li><b>XenServer and OCaml: a brief history</b>
      <ul>
      <li>What is XenServer? </li>
      <li> Where is the OCaml? </li>
      </ul>
    </li>
    <li>Low-level systems programming in OCaml
      <ul>
      <li>OCaml in kernel space;</li>
      <li>Run OCaml directly on the cloud</li>
      </ul>
    </li>
    <li>Future XenServer architecture
      <ul>
      <li>Where OCaml fits</li>
      </ul>
    </li>
  </ol>
  >>;
};

{
  styles=[];
  content= <:html<
    <h3>What is XenServer?</h3>
    <ul>
      <li>a hypervisor platform</li>
      <li>based on open-source xen, Linux, CentOS</li>
      <li>turns a set of physical machines into a single, flexible substrate on which VMs can be installed, migrated around, etc etc</li>
    </ul>
    <br/>
    <section>
    <object data="xenserver.svg" type="image/svg+xml">&nbsp;</object>
    </section>
    <br/>
<!--
    <center><a href="http://www.citrix.com/products/xenserver/try.html">http://www.citrix.com/products/xenserver/try.html</a></center>
-->
  >>;
};
{
  styles=[];
  content= <:html<
    <h3>So... where did we put the OCaml?</h3>
    <section>
    <object data="xenserver-ocaml.svg" type="image/svg+xml">&nbsp;</object>
    </section>
  >>;
};
{
  styles=[];
  content= <:html<
    <h3>Why did we choose OCaml??!</h3>
    <ul>
    <li> Back in 2006 we were:
      <ul>
      <li> XenSource: a VC-funded spin-off from the <a href="http://www.cl.cam.ac.uk/">University of Cambridge Computer Lab</a></li>
      <li> Building software to manage datacenters running the <a href="http://www.xen.org/">xen</a> hypervisor</li>
      </ul>
    </li>
    <li> Back in 2006 we had:
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
    <li> We knew we were spending <b>waaaay</b> too much time
      <ul>
      <li> tediously parsing strings (protocols, CLIs, config files)</li>
      <li> tracking down the root cause of memory corruption</li>
      </ul>
    </li>
    <li> We knew we were spending <b>waaaay</b> too little time
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
    <li> .. and then you can generate code</li>
    </ul>
  >>;
};
{
  styles=[];
  content= <:html<
    <h3>Why did we choose OCaml??!</h3>
    <ul>
    <li> 3 of us had FP experience (standard ML and then OCaml)</li>
    <li> we knew that we could benefit from
    <ul>
      <li>algebraic data types</li>
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
    <h3>So a document generator was born</h3>
    <ul>
    <li> a declarative API spec was converted into pdf (via latex)</li>
    <li> how did we know the API was actually going to work?
      <ul>
      <li>clearly we needed a quick prototype implementation</li>
      </ul>
    </li>
    <li> we quickly generated some API stubs, skeletons</li>
    <li> we quickly hooked up the skeletons to some "actuators" (xen hypercalls etc)</li>
    <li> ... </li>
    <li> the result was pretty impressive! </li>
    <li> ... </li>
    <li> shall we move the product over to this new codebase then? </li>
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
    <h3>Talk structure</h3>
    <ol>
    <li>XenServer and OCaml: a brief history
      <ul>
      <li>What is XenServer? </li>
      <li> Where is the OCaml? </li>
      </ul>
    </li>
    <li><b>Low-level systems programming in OCaml</b>
      <ul>
      <li>OCaml in kernel space;</li>
      <li>Run OCaml directly on the cloud</li>
      </ul>
    </li>
    <li>Future XenServer architecture
      <ul>
      <li>Where OCaml fits</li>
      </ul>
    </li>
  </ol>
  >>;
};

{
  styles=[];
  content= <:html<
    <h3>Mirage: OCaml in kernel space</h3>
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
    <h3>Example: this presentation</h3>
    <section>
    <object data="website.svg" type="image/svg+xml">&nbsp;</object>
    </section>
  >>
};

{ styles=[];
  content= <:html<
    <h3>Building an OCaml kernel is easy</h3>
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
{
  styles=[];
  content= <:html<
    <h3>Talk structure</h3>
    <ol>
    <li>XenServer and OCaml: a brief history
      <ul>
      <li>What is XenServer? </li>
      <li> Where is the OCaml? </li>
      </ul>
    </li>
    <li>Low-level systems programming in OCaml
      <ul>
      <li>OCaml in kernel space;</li>
      <li>Run OCaml directly on the cloud</li>
      </ul>
    </li>
    <li><b>Future XenServer architecture</b>
      <ul>
      <li>Where OCaml fits</li>
      </ul>
    </li>
  </ol>
  >>;
};

{ styles=[];
  content= <:html<
    <h3>"Project Windsor": disaggregating domain 0</h3>
    <ul>
      <li> Isolate components in (small) VMs e.g.
        <ul>
        <li> Individual device drivers (NIC x; HBA y)</li>
        <li> Individual services (per-VM hardware emulators</li>
        </ul>
      </li>
      <li> <b>Increase reliability:</b> Monitor, crash and restart on failure (Erlang-style)</li>
      <li> <b>Better scalability:</b> Dynamically scale-out across NUMA nodes</li>
      <li> <b>More secure:</b> Reduce size of the Trusted Computing Base</li>
    </ul>
  >>
};

{ styles=[];
  content= <:html<
    <h3>"Project Windsor": where OCaml helps</h3>
    <ul>
      <li> The same code can be run in user-space (as normal) or kernel-space (via Mirage)
        <ol>
        <li>Debug in user-space, deploy in kernel-space</li>
        </ol>
      </li>
      <li> Only include the libraries you actually need
        <ol>
        <li> Low memory footprint</li>
        <li> Extremely fast boot</li>
        <li> Helps keep the TCB small</li>
        </ol>
      </li>
      <li> High performance
        <ol>
        <li> No layers of legacy code </li>
        <li> No need for separate kernel and user-space within a Mirage VM</li>
        </ol>
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
    <h3>Summary</h3>
    <ul>
      <li> using higher-level tools like OCaml, helps us <b>generate more value</b> for the company
        <ol>
        <li> I claim the complexity of our software is due to the problem domain, not the programming language(s)</li>
        <li> You can think of OCaml as "a better C" (if that helps) </li>
        </ol>
      </li>
      <li> virtualization allows us to rethink how our OSes and applications are structured
      <ol>
        <li>Remember Rob Pike's "Systems Software Research is Irrelevant"?</li>
        <li>OCaml in kernel mode is liberating and fun</li>
      </ol>
      </li>
      <li><b>Citrix is a great company</b> - speak to me to find out more</li>
    </ul>
  >>
};
]
