# OMNI-DRONE-LUA-LIBRARY

<p>This is an open-source Lua based framework-library for creating Omni-Drones in Modded Minecraft.
  
</br>Visit [this repository](https://github.com/19PHOBOSS98/OMNI-DRONES) to get started in building your own OMNI-DRONE SWARM!!!
  
</br>[Valkyrien Skies 2 (VS2)](https://modrinth.com/mod/valkyrien-skies) is a Minecraft Mod that turns player-built structures into physics objects. With it is a growing army of [addons](https://wiki.valkyrienskies.org/wiki/List_of_addons) that "add" stuff to make them fly among other things. Coupled with [ComputerCraft (CC)](https://modrinth.com/mod/cc-tweaked) we can achieve stable omnidirectional flight.

</br>Visit their discord servers: ([VS2](https://discord.gg/aWeNDCUTS6), [CC](https://discord.gg/dRTtrdK)) to learn more.

</p>



</br>
Some cool stuff about the library that I think is worth mentioning:

<ul>
   <li>
      <b>Pulse Width Modulation</b>
      <p> 
         - When using Redstone controlled thrusters for propulsion, the system uses PWM Redstone signals to have finer control over the thrusters. Redstone only operates in integer values ranging from 0 to 15, making it very difficult to have precise thrust vectoring without modulating the signals.
      </p>
   </li>
         
   <li>
      <b>Thrust Vectoring</b>
      <p>
         - The system uses thrust vectoring techniques to allow omnidirectional flight. The net thrust of all the onboard thrusters controls the aircrafts position and orientation in space.
      </p>
   </li>
   <li>
      <b>Automatic Jacobian Matrix Construction</b>
      <p>
         - Here, a Jacobian matrix is used to map the needed net force and torque to the individual onboard thrusters' force and torque values to control the aircraft. I've made it so the system would build the matrix for you from a list of onboard active thrusters. 
      </p>
   </li>
   <li>Swappable <b>Feedback Controllers</b>:
      <p>
         - A feedback control loop is used to achive precise control over the aircraft's flight behaviour. I've mostly used P.I.D. controllers for the time being. Though, I've made it so that the framework allows the users to easily swapout the default controller with any feedback controller they might need or want.
      </p>
      <ul>
         <li>
            <b>PID Controllers</b>
            <p>
               - Proportional, Integral and Derivative feedback control is considered one of the simplest and widely used control loops in control systems. Here, I demonstrate the use of two of its most common forms:
            </p>
            <ul>
               <li>
                  Continuous
                  <p>
                  - I used a continuous implementation of a PID controller when I started out building this library. It's meant to sample error values in a continuous time domain. That means it needs smooth frame rates to work. When I started moving out of the test phase and into a laggy game server, I had to use a discrete PID controller.
                  </p>
               </li>
               <li>
                  Discrete
                  <p>
                  - While not as accurate as continuous PID controllers, this can adapt to changing sample time intervals. This makes it more suitable for laggy PVP servers.
                  </p>
               </li>
            </ul>
         </li>
         <li>
            More Feedback Controllers To Be Added
            <p>
            - I plan to implement <b>full-state feedback controllers</b> like <b>LQR and LQG</b> in the future.
            </p>
         </li>
      </ul>
   </li>
   <li>
      <b>Quaternion</b> Orientation
      <p>
         - Instead of using Euler angles, I use quaternions to measure aircraft rotation errors. This helps to avoid gimbal lock and have the ship turn smoother. 
      </p>
   </li>
   <li>
      <b>Inertia Tensors</b>
      <p>
         - PID controllers would usually be enough to control rotation by themselves, but setting the gains too often gets repetitive whenever the player changes the aircrafts form and weight distribution either while building or in combat. Though, unrealistic in the real world, including the complete unsymetrical inertia tensor in the control loop's plant model made it possible for the aircraft to adapt to structural changes in real time:
         <div align="center">
            </br>
            (The picture is linked to a video, click on it!)
            </br>
            <a href="https://youtu.be/Kqf0vo2cnQA?si=FZWUhKSWGSw9sOlh"><img src="https://github.com/user-attachments/assets/0d73e731-f94c-417a-93f8-48bfdaf2e32e" width=500></a>
         </div>
      </br> In earlier versions of the mod, I had to calculate the inertia tensor <a href="https://github.com/19PHOBOSS98/TILT_SHIP_MINECRAFT_SCHEMATIC_INERTIA_TENSOR_CALCULATOR">myself</a> from point cloud data (minecraft structure schematics).
      </p>
   </li>
   
   
   
   
</ul>

rename this folder to "lib" so the classes can find each other

⁹# UPDATES
So far Sep 8, 2024: 
the VS+Tournament devs are still working on puting back the API in recent versions for MC 1.20.1. That makes it less convenient to build an omni-drone using Tournament thrusters on 1.20.1 than on 1.18.2. Until then, maybe you can still have fun in 1.18.2 :)

You should still be able to use Kontraption tho on 1.20.1.
