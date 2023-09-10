package com.sev7en.chatsphere.Screens

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.database.DataSnapshot
import com.google.firebase.database.DatabaseError
import com.google.firebase.database.DatabaseReference
import com.google.firebase.database.FirebaseDatabase
import com.google.firebase.database.ValueEventListener
import com.sev7en.chatsphere.Adapters.ItemClicked
import com.sev7en.chatsphere.Adapters.UserDataModel
import com.sev7en.chatsphere.Adapters.UserRecyclerViewAdapter
import com.sev7en.chatsphere.R

// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [HomeFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class HomeFragment : Fragment(), ItemClicked {
    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private var param2: String? = null




    // variables of the fragment
    private lateinit var recyclerview: RecyclerView
    private lateinit var userList: ArrayList<UserDataModel>
    private lateinit var mAuth: FirebaseAuth
    private lateinit var mDbRef: DatabaseReference





    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {
            param1 = it.getString(ARG_PARAM1)
            param2 = it.getString(ARG_PARAM2)
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_home, container, false)
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment HomeFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            HomeFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }





    // Code of the Fragment
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        // Initialize mAuth
        mAuth = FirebaseAuth.getInstance()
        mDbRef = FirebaseDatabase.getInstance().reference

        // Initialize userList
        userList = ArrayList()


        // for demo purpose
        //dataInitilize(mDbRef)


        //linking recycler view
        recyclerview = view.findViewById(R.id.recyclerview)
        recyclerview.layoutManager = LinearLayoutManager(context)
        val adapter = UserRecyclerViewAdapter(this)
        recyclerview.adapter = adapter



        // use database reference to get all users
        mDbRef.child("User").addValueEventListener(object : ValueEventListener{
            override fun onDataChange(snapshot: DataSnapshot) {

                //userList.clear()

                //get all users by iterating through the child User using snapshot
                for(postSnapshot in snapshot.children) {
                    val currentUser = postSnapshot.getValue(UserDataModel::class.java)

                    if (currentUser != null) {
                        userList.add(currentUser)
                    } else {
                        Log.d("Dev", "Current user is null")
                    }

                    Log.d("Dev", "Added a user in list")

                }
                adapter.updateList(userList)

            }

            override fun onCancelled(error: DatabaseError) {
                Log.e("Dev", "Error: ${error.message}")
            }

        })
    }

    override fun onItemClicked(user: UserDataModel) {

        Log.d("Dev", "${user.uid} clicked")

        Toast.makeText(context, "${user.uid} clicked", Toast.LENGTH_SHORT).show()
    }
}