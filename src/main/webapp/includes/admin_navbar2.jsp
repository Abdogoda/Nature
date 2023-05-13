
   <nav>
    <i class="fas fa-bars sidebar-toggler"></i>
    <form action="#">
     <div class="form-input">
      <input type="search" placeholder="Search..." />
      <button type="submit" class="search-btn">
       <i class="fas fa-search"></i>
      </button>
     </div>
    </form>
    <input type="checkbox" id="switch-mode" hidden />
    <label for="switch-mode" class="switch-mode"></label>
    <a href="#" class="notification">
     <i class="fas fa-bell"></i>
     <span class="num">8</span>
    </a>
    <% if(admin != null){ %>
	    <a href="profile.jsp?id=<%= admin.getId() %>" class="profile">
	     <img src="uploaded_img/users/<%= admin.getImage() %>" />
	    </a>
    <%} %>
    <div class="notification-box">
     <ul>
      <li>
       <div class="left">
        <i class="fa fa-bell"></i>
        <a href="#" class="content">
         <span class="title">WareHouse</span>
         <p class="message">There is a new product in warehouse</p>
        </a>
       </div>
       <div class="right">
        <div class="time"><i class="fa fa-clock"></i>2 Nov 2022 at 9:30 AM</div>
        <div class="trash-box"><i class="fa fa-trash"></i></div>
       </div>
      </li>
      <li>
       <div class="left">
        <i class="fa fa-bell"></i>
        <a href="#" class="content">
         <span class="title">WareHouse</span>
         <p class="message">There is a new product in warehouse</p>
        </a>
       </div>
       <div class="right">
        <div class="time"><i class="fa fa-clock"></i>2 Nov 2022 at 9:30 AM</div>
        <div class="trash-box"><i class="fa fa-trash"></i></div>
       </div>
      </li>
      <li>
       <div class="left">
        <i class="fa fa-bell"></i>
        <a href="#" class="content">
         <span class="title">WareHouse</span>
         <p class="message">There is a new product in warehouse</p>
        </a>
       </div>
       <div class="right">
        <div class="time"><i class="fa fa-clock"></i>2 Nov 2022 at 9:30 AM</div>
        <div class="trash-box"><i class="fa fa-trash"></i></div>
       </div>
      </li>
      <li>
       <div class="left">
        <i class="fa fa-bell"></i>
        <a href="#" class="content">
         <span class="title">WareHouse</span>
         <p class="message">There is a new product in warehouse</p>
        </a>
       </div>
       <div class="right">
        <div class="time"><i class="fa fa-clock"></i>2 Nov 2022 at 9:30 AM</div>
        <div class="trash-box"><i class="fa fa-trash"></i></div>
       </div>
      </li>
      <li>
       <div class="left">
        <i class="fa fa-bell"></i>
        <a href="#" class="content">
         <span class="title">WareHouse</span>
         <p class="message">There is a new product in warehouse</p>
        </a>
       </div>
       <div class="right">
        <div class="time"><i class="fa fa-clock"></i>2 Nov 2022 at 9:30 AM</div>
        <div class="trash-box"><i class="fa fa-trash"></i></div>
       </div>
      </li>
     </ul>
     <a href="notifications.jsp" class="view-all"
      >View All Notifications <i class="fa fa-arrow-right"></i
     ></a>
    </div>
   </nav>
  